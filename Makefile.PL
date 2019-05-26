use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

use strict;

my @ALLOWED_ARGS = ('INSTALLDIRS','DESTDIR');

# Parse command line arguments and store them as environment variables
while ($_ = shift) {
	my ($k,$v) = split(/=/, $_, 2);
	if (grep(/^$k$/, @ALLOWED_ARGS)) {
		$ENV{$k} = $v;
	}
}
$ENV{DESTDIR} =~ s/\/$//;

# Default install path
my $DESTDIR = $ENV{DESTDIR} || '';
my $INSTALLDIRS = $ENV{INSTALLDIRS} || 'site';
my %merge_compat = ();

if ($ExtUtils::MakeMaker::VERSION >= 6.46) {
	%merge_compat = (
		'META_MERGE'   => {
			resources  => {
				homepage => 'https://github.com/darold/pg_dumpbinary',
				repository  => {
					type => 'git',
					git => 'git@github.com:darold/pg_dumpbinary.git',
					web => 'https://github.com/darold/pg_dumpbinary',
				},
			},
		}
	);
}

WriteMakefile(
	'DISTNAME'	=> 'pg_dumpbinary',
	'NAME'		=> 'pg_dumpbinary',
	'VERSION'	=> '1.0',
	'dist'  => {
			'COMPRESS'=>'gzip -9f', 'SUFFIX' => 'gz',
			'ZIP'=>'/usr/bin/zip','ZIPFLAGS'=>'-rl'
		   },
	'AUTHOR'       => 'Gilles Darold (gilles@darold.net)',
	'ABSTRACT'     => 'pg_dumpbinary - PostgreSQL log analysis report',
	'EXE_FILES'    => [ qw(pg_dumpbinary) ],
	'MAN1PODS'     => { 'doc/pg_dumpbinary.pod' => 'blib/man1/pg_dumpbinary.1p','doc/pg_restorebinary.pod' => 'blib/man1/pg_restorebinary.1p' },
	'DESTDIR'      => $DESTDIR,
	'INSTALLDIRS'  => $INSTALLDIRS,
	'clean'	       => {},
	%merge_compat
);
