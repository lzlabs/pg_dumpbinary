# How to contribute

## Before Submitting an issue

1. Upgrade to the latest version of pg_dumpbinary and see if the problem remains

2. Look at the [closed issues](https://github.com/lzlabs/pg_dumpbinary/issues?state=closed), we may have already answered a similar problem

3. [Read the doc](http://lzlabs.github.com/pg_dumpbinary/). It is short and useful.


## Coding style

pg_dumpbinary project provides a [.editorconfig](http://editorconfig.org/) file to
setup consistent spacing in files. Please follow it!


## Keep Documentation Updated

pg_dumpbinary documentation can be obtained first with `pg_dumpbinary --help`
and `pg_restorebinary --help`. Man page are generated from POD files in `doc/`
directory using pod2man. The `README.md` is the description of the utilities
containing global information and usage of commands from `--help` option.

