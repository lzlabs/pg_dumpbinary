use Test::Simple tests => 10;

my $ret = ``;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
$ret = `createdb test_bin_dump_dest`;
ok( $? == 0, "Destination test database created");
`rm -rf t/test_bin_dump/ >/dev/null 2>&1`;
$ret = `perl pg_dumpbinary -n '"SEQNSP"' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 7, "Dump test database for sequence namespace");
ok( `grep "test_seq[12]_id_seq.5" t/test_bin_dump/data-sequences.lst | wc -l` == 2, "Number of sequence exported");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary -t '"SEQNSP".test_seq1' -t '"SEQNSP".test_seq2' -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0 && `ls t/test_bin_dump/ | wc -l` == 7, "Dump test sequence export with filter on tables");
ok( `grep "test_seq[12]_id_seq.5" t/test_bin_dump/data-sequences.lst | wc -l` == 2, "Number of sequence exported");
`rm -rf t/test_bin_dump`;
$ret = `perl pg_dumpbinary -d test_bin_dump_orig t/test_bin_dump`;
ok( $? == 0, "Dump all from orig database");
$ret = `psql -d test_bin_dump_dest -c 'CREATE SCHEMA "SEQNSP";'`;
ok( $? == 0, "Create schema to destination database");
$ret = `perl pg_restorebinary -n 'SEQNSP' -d test_bin_dump_dest t/test_bin_dump`;
ok( $? == 0, "Restore all tables from sequences schema");
$ret = `psql -d test_bin_dump_dest -Atc "select count(*) from pg_class c join pg_namespace n ON (c.relnamespace = n.oid) where relkind = 'S' and n.nspname = 'SEQNSP';"`;
ok( $? == 0 && $ret == 2, "All sequences restored");
$ret = `psql -d test_bin_dump_dest -Atc 'SELECT last_value FROM "SEQNSP".test_seq1_id_seq;'`;
ok( $? == 0 && $ret == 5, "Look for next value for a sequence to verify that it have been set");

# Clean all
`rm -rf t/test_bin_dump`;
`dropdb test_bin_dump_orig >/dev/null 2>&1`;
`dropdb test_bin_dump_dest >/dev/null 2>&1`;
