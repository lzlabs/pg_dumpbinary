use Test::Simple tests => 6;

my $ret = ``;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
$ret = `createdb test_bin_dump_dest`;
ok( $? == 0, "Destination test database created");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary --table '"BTEST"."T1"' --where '"COL1" >= 66' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 4, "Dump test database for partial dump");
ok( `ls t/test_bin_dump/meta-BTEST.T1.txt | wc -l` == 1, "Selected table dumped");
$ret = `psql -d test_bin_dump_dest -c 'CREATE SCHEMA "BTEST";'`;
ok( $? == 0, "Create schema to destination database");
$ret = `perl pg_restorebinary -n 'BTEST' -t 'T1' --truncate -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore the selected table with the filtered data");
$ret = `psql -d test_bin_dump_dest -Atc 'select count(*) from "BTEST"."T1";'`;
ok( $? == 0 && $ret == 35, "Table and filtered data restored");

# Clean all
`rm -rf t/test_bin_dump`;
`dropdb test_bin_dump_orig >/dev/null 2>&1`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
