use Test::Simple tests => 8;

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
$ret = `perl pg_dumpbinary -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0, "Dump test database in binary format");
$ret = `perl pg_restorebinary -i t/test_bin_dump | grep "dbname: test_bin_dump_orig"`;
ok( $? == 0 && $ret =~ /dbname: test_bin_dump_orig/, "Get information from the dump");
$ret = `perl pg_restorebinary -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore test database in binary format into test_bin_dump_dest");
$ret = `pg_dump -d test_bin_dump_dest > t/sql/db_test_new.sql`;
ok( $? == 0, "Dump destination database");
$ret = `diff t/sql/db_test_new.sql t/sql/db_test_orig.sql`;
ok( $? == 0 && $ret eq '', "Good! No differences between source and destination database.");

`rm -rf t/test_bin_dump`;
`rm t/sql/db_test_new.sql`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
