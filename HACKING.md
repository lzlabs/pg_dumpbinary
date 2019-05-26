# Contributing on pg_dumpbinary

Thanks for your attention on pg_dumpbinary ! You need Perl Module Time::HiRes
if your distribution doesn't install it by default.

pg_dumpbinary has a TAP compatible test suite executed by `prove`:

    $ prove
    t/01_lint.t ....... ok   
    t/02_basic.t ...... ok   
    t/03_namespace.t .. ok     
    All tests successful.
    Files=3, Tests=26,  8 wallclock secs ( 0.02 usr  0.01 sys +  3.19 cusr  0.70 csys =  3.92 CPU)
    Result: PASS
    $

or if you prefer to run test manually:

    $ perl Makefile.PL && make test
    Checking if your kit is complete...
    Looks good
    Generating a Unix-style Makefile
    Writing Makefile for pg_dumpbinary
    Writing MYMETA.yml and MYMETA.json
    cp pg_dumpbinary blib/script/pg_dumpbinary
    "/usr/bin/perl" -MExtUtils::MY -e 'MY->fixin(shift)' -- blib/script/pg_dumpbinary
    PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
    t/01_lint.t ....... ok   
    t/02_basic.t ...... ok   
    t/03_namespace.t .. ok     
    All tests successful.
    Files=3, Tests=26,  8 wallclock secs ( 0.03 usr  0.01 sys +  3.40 cusr  0.65 csys =  4.09 CPU)
    Result: PASS
    $ make clean && rm Makefile.old

Please contribute a regression test when you fix a bug or add a feature. Thanks!
