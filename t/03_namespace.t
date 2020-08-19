use Test::Simple tests => 18;

my $ret = ``;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
$ret = `createdb test_bin_dump_dest`;
ok( $? == 0, "Destination test database created");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary -n '"BTEST"' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 8, "Dump test database for single namespace");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary -n '"BTEST"' -t '"BTEST"."T1"' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 3, "Dump test database for single table");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary -n '"BTEST"' -T '"BTEST"."T1"' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 7, "Dump test database excluding single table");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0, "Dump all from orig database");
$ret = `psql -d test_bin_dump_dest -c 'CREATE SCHEMA "BTEST";'`;
ok( $? == 0, "Create destination schema");
$ret = `perl pg_restorebinary -n 'BTEST' -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore all tables from one schema");
$ret = `psql -d test_bin_dump_dest -Atc "select count(\*) from pg_class c join pg_namespace n ON (c.relnamespace = n.oid) where relkind = 'r' and n.nspname = 'BTEST';"`;
ok( $? == 0 && $ret == 6, "All tables in schema restored");
$ret = `psql -d test_bin_dump_dest -c 'DROP TABLE "BTEST"."T1";'`;
ok( $? == 0, "Drop one table in the restored schema to restore it");
$ret = `perl pg_restorebinary -n 'BTEST' -t 'T1' -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore only one table into a schema");
$ret = `psql -d test_bin_dump_dest -Atc "select count(\*) from pg_class c join pg_namespace n ON (c.relnamespace = n.oid) where relkind = 'r' and n.nspname = 'BTEST';"`;
ok( $? == 0 && $ret == 6, "All tables in schema present");
$ret = `psql -d test_bin_dump_dest -Atc 'select count(\*) from "BTEST"."T1";'`;
ok( $? == 0 && $ret == 100, "All data restored");
$ret = `psql -d test_bin_dump_dest -c 'TRUNCATE "BTEST"."T1";'`;
ok( $? == 0, "Truncate table to restore only data");
$ret = `perl pg_restorebinary -a -n 'BTEST' -t 'T1' -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore only data from one table");
$ret = `psql -d test_bin_dump_dest -Atc 'select count(\*) from "BTEST"."T1";'`;
ok( $? == 0 && $ret == 100, "All data restored");
$ret = `psql -d test_bin_dump_dest -Atc 'select count(\*) from "BTEST"."measurement";'`;
ok( $? == 0 && $ret == 3, "All data restored in partitions");
$ret = `psql -d test_bin_dump_dest -Atc 'select count(\*) from "BTEST"."measurement_y2017";'`;
ok( $? == 0 && $ret == 1, "All data restored in one partition");
`rm -rf t/test_bin_dump`;

# Make a diff between source and destination database
# to be sure that everything is present
`perl pg_dumpbinary -d test_bin_dump_orig t/test_bin_dump`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
`createdb test_bin_dump_dest`;
`perl pg_restorebinary -d test_bin_dump_dest t/test_bin_dump`;
`pg_dump test_bin_dump_orig > src.sql`;
`pg_dump test_bin_dump_dest > dst.sql`;
$ret = `diff src.sql dst.sql > /dev/null`;
ok( $? == 0 && $ret eq '', "Origin and restored database are exactly the same");

# Clean all
`rm -f src.sql dst.sql`;
`rm -rf t/test_bin_dump`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
