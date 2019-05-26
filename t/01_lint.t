use Test::Simple tests => 3;

my $ret = `perl -wc pg_dumpbinary 2>&1`;
ok( $? == 0, "PERL syntax check for pg_dumpbinary");

my $ret = `perl -wc pg_restorebinary 2>&1`;
ok( $? == 0, "PERL syntax check for pg_restorebinary");

$ret = `podchecker doc/*.pod 2>&1`;
ok( $? == 0, "pod syntax check");

