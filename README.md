# PostgreSQL binary dump

pg_dumpbinary is a program used to dump a PostgreSQL database with
data dumped in binary format. The resulting dumps must be restored
using pg_restorebinary.

## pg_dumpbinary

pg_dumpbinary is useful in some situations:

* you have bytea that can not be exported by pg_dump because the
  total size of the escape/hex output exceed 1Gb.
* you have custom type that stores `\0` internally in bytea but data
  are returned as char/varchar/text which truncate data after
  the '\0'. In this case pg_dump will export data in the output
  type which will result in data lost.
* any other case where binary format can be useful.

If you are in this case pg_dumpbinary will help you by dumping the
PostgreSQL database in binary format. In all other cases you must
use the pg_dump/pg_restore commands distributed with PostgreSQL.

The program creates a directory with the name given as parameter for
the backup then it dump pre-data and post-data section using pg_dump
in this directory.

pg_dumpbinary collect the list of schemas and tables from the pre-data
section and execute through the psql command the SQL COPY orders to
dump all data in binary format from all tables. The COPY statement
looks like:

    COPY my_table TO stdout WITH (FORMAT binary);

All data are exported into a file per table named:

    data-schema.table.bin.gz

The file is compressed on the fly using gzip.

The backup can be restored using pg_restorebinary program.

pg_dumpbinary creates consistent backups, the database server needs to
support synchronized snapshots, a feature that was introduced in PG 9.2
for primary servers and 10 for standbys. pg_dumpbinary will refuse to
dump database that do not respect these minimum versions.

pg_dumpbinary uses multiple database connections; it connects to the
database once with the master process to create a synchronized snapshot
and dump the pre-data section. Once again for each worker job using the
synchronized snapshot.

## pg_restorebinary

pg_restorebinary is a tool used to restore a PostgreSQL database dumped
using pg_dumpbinary command in binary format.

The program read the directory given as parameter for the backup then it
restore the pre-data section in the database given at -d option. Once it
is done it proceed to data import. All data file are uncompressed on the
fly and sent to a psql command using COPY SQL order like:

    COPY my_table FROM stdin WITH (FORMAT binary);

Then post-data section are imported into the new database.

## Installation

pg_dumpbinary and pg_restorebinary are Perl program that do not require
anything than Perl itself, Perl modules DBD::Pg and DateTime. The PostgreSQL
commands pg_dump, pg_restore and psql must be available through the PATH
environment variable. Data are compressed using gzip.

THe Perl module Date::Time can be installed using `sudo apt install libdatetime-perl`
or `sudo yum install perl-Date-Time`. You can also install it
from sources downloaded from [CPAN](https://metacpan.org/pod/Date::Time).

Perl module DBD::Pg can be installed using `sudo apt install libdbd-pg-perl`
or `sudo yum install perl-DBI perl-DBD-Pg`. You can also install it
from sources downloaded from [CPAN](https://metacpan.org/pod/DBD::Pg).

To install pg_dumpbinary:

```
perl Makefile.PL
make
sudo make install
```

## Usage

### pg_dumpbinary

Program used to dump a PostgreSQL database with data dumped in binary
format. The resulting dumps can be restored using pg_restorebinary.

```
usage: pg_dumpbinary -d dbname [options] backup_name

    backup_name   output directory where dump will be saved. Default
                  directory name is binary_bkup_YYYY-MM-DDTHH:MM:SS
		  when no output directory is provided.
options:

  -d, --database DBNAME        database to dump
  -h, --host HOSTNAME          database server host or socket directory
  -j, --job NUM                use this many parallel jobs to dump
  -n, --schema SCHEMA          dump the named schema(s) only
  -N, --exclude-schema SCHEMA  do NOT dump the named schema(s)
  -p, --port PORT              database server port number, default: 5432
  -t, --table TABLE            dump named relation
  -T, --exclude-table TABLE    do NOT dump the named table
  -u, --user NAME              connect as specified database user
  -v, --version                show program version
  --help                       show usage
  --load-via-partition-root    dump data through partitioned table only, make
                               the COPY statements target the root of the
			       partitioning hierarchy rather than the partition
```

### pg_restorebinary

Program used to restore a PostgreSQL binary dump generated with
pg_dumpbinary. It can not be used to restore other PostgreSQL
dump.

```
usage: pg_restorebinary [options] -d dbname backup_dir

  backup_dir   directory where backup files to restore will be read.
               It must be a directory created by pg_dumpbinary.
options:

  -a, --data-only              restore only the data, no schema
  -d, --database DBNAME        database to restore, it must exists
  -h, --host HOSTNAME          database server host or socket directory
  -i, --info                   print information about the dump and exit
  -j, --job NUM                use this many parallel jobs to restore
  -n, --schema SCHEMA          restore the named schema(s) only
  -N, --exclude-schema SCHEMA  do NOT restore the named schema(s)
  -p, --port PORT              database server port number, default: 5432
  -t, --table TABLE            restore named relation
  -T, --exclude-table TABLE    do NOT restore the named table
  -u, --user NAME              connect as specified database user
  -v, --version                show program version
  --help                       show usage
  --disable-triggers           disable triggers during data restore
  --truncate                   truncate the table before importing the data

```

## Parallel processing

The speed of the dump can be improved by using parallelism during the
export by pg_dumpbinary. Set option -j with the number of simultaneous
process you want to use. The behaviour is like the -j option of pg_dump
in directory format. 

Similary restoration speed can be improved by using parallelism during
the call to pg_restorebinary. Set option -j with the number of simultaneous
process you want to use. The behaviour is like the -j option of pg_restore.

The parallelism is also used to restore post-data section for indexes and
constraints.

## Binary format

pg_dumpbinary stores as binary format all tables data, it is fast but
note that it is less portable across machine architectures and PostgreSQL
versions. The binary format is very data type specific, it is not possible
to import data in columns with a different type.

## Authors

Gilles Darold.

## License

pg_dumpbinary is free software distributed under the PostgreSQL Licence.

Copyright (c) 2019-2021 LzLabs, GmbH

