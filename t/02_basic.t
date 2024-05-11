#!/usr/bin/perl
use Test::Simple tests => 14;

my $ret = ``;
`dropdb test_bin_dump_orig >/dev/null 2>&1`;
$ret = `createdb test_bin_dump_orig`;
ok( $? == 0, "Source test database created");
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
$ret = `createdb test_bin_dump_dest`;
ok( $? == 0, "Destination test database created");
$ret = `psql -d test_bin_dump_orig -f t/sql/db_test_orig.sql`;
ok( $? == 0, "Import test content into source database test_bin_dump_orig");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary -j 2 -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0, "Dump test database in binary format");
$ret = `perl pg_restorebinary -i t/test_bin_dump | grep "dbname: test_bin_dump_orig"`;
ok( $? == 0 && $ret =~ /dbname: test_bin_dump_orig/, "Get information from the dump");
$ret = `perl pg_restorebinary -d test_bin_dump_dest --truncate t/test_bin_dump`;
ok( $? == 0, "Restore test database in binary format into test_bin_dump_dest");
$ret = `pg_dump -d test_bin_dump_dest > t/sql/db_test_new.sql`;
ok( $? == 0, "Dump destination database");
$ret = `diff t/sql/db_test_new.sql t/sql/db_test_orig.sql | grep -vE -- "^(--|[123456789]|[<>] SET |[<>] --)" | grep -vE "(ALTER|REVOKE|GRANT) .*SCHEMA public" | grep -vE "^[<>] \$"`;
ok( $ret eq '', "Differences between source and destination database.");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary -j 2 -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/meta-BTEST.measurement* | wc -l` == 3, "Dump partitions not partitioned table");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary --load-via-partition-root -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/meta-BTEST.measurement* | wc -l` == 1, "Dump data through partition root only");
$ret = `diff t/sql/db_test_new.sql t/sql/db_test_orig.sql | grep -vE -- "^(--|[123456789]|[<>] SET |[<>] --)" | grep -vE "(ALTER|REVOKE|GRANT) .*SCHEMA public" | grep -vE "^[<>] \$"`;
ok( $ret eq '', "Differences between databases with use of --load-via-partition-root.");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary --compress-level=0 -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/*.gz 2>/dev/null | wc -l` == 0, "Dump with no data compression");
$ret = `perl pg_restorebinary -a -d test_bin_dump_dest --truncate t/test_bin_dump`;
ok( $? == 0, "Restore uncompressed data into test_bin_dump_dest");

my $createdb = qq{CREATE DATABASE test_bin_dump_orig WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'fr_FR.UTF-8';
ALTER DATABASE test_bin_dump_orig OWNER TO gilles;
};
$ret = `perl pg_restorebinary --dump-create t/test_bin_dump`;
ok( $? == 0 && $ret eq $createdb, "Dump create database statements: $ret");


`cp -r t/test_bin_dump t/test_bin_dump2`;
`rm -rf t/test_bin_dump`;
`rm t/sql/db_test_new.sql`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
