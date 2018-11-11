# Fano CLI

Fano CLI is command line tools to help scaffolding web application using [Fano Web Framework](https://github.com/fanoframework/fano).

- [Scaffolding with Fano CLI](https://fanoframework.github.io/scaffolding-with-fano-cli/)

## Requirement

- [Free Pascal](https://www.freepascal.org/) >= 3.0

## Installation

### Setting up

Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run

    $ fpc -i

If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.

Clone this repository

    $ git clone git@github.com:fanoframework/fano-cli.git

## Copy compiler configurations

Copy `*.cfg.sample` to `*.cfg`.

```
$ cp build.prod.cfg.sample build.prod.cfg
$ cp build.dev.cfg.sample build.dev.cfg
$ cp build.cfg.sample build.cfg
```

Make adjustment as you need in `build.cfg`, `build.prod.cfg`, `build.dev.cfg`.

These `*.cfg` files contain some Free Pascal compiler switches that you can turn on/off to change how executable is compiled and generated. For complete
explanation on available compiler switches, consult Free Pascal documentation.

`tools/config.setup.sh` shell script is provided to simplify copying those
configuration files. Following shell command is similar to command above.

    $ ./tools/config.setup.sh

## Build

Run `build.sh` (or `build.cmd` if on Windows) script to compile application.

    $ ./build.sh

By default, it will output binary executable in `bin/out` directory.

### Build for different environment

To build for different environment, set `BUILD_TYPE` environment variable.

#### Build for production environment

    $ BUILD_TYPE=prod ./build.sh

Build process will use compiler configuration defined in `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.

#### Build for development environment

    $ BUILD_TYPE=dev ./build.sh

Build process will use compiler configuration defined in `build.cfg` and `build.dev.cfg`.

If `BUILD_TYPE` environment variable is not set, production environment will be assumed.

## Change executable output directory

Compilation will output executable to directory defined in `EXEC_OUTPUT_DIR`
environment variable. By default is `bin/out` directory.

    $ EXEC_OUTPUT_DIR=/path/to/exec/dir ./build.sh

## Change compiled units output directory

Compilation will output compiled units to directory defined in `UNIT_OUTPUT_DIR`
environment variable. By default is `bin/unit` directory.

    $ UNIT_OUTPUT_DIR=/path/to/compiled/units/dir ./build.sh

## Run

Copy `bin/out/fanocli` executable file to directory that is accessible globally,
for example `/usr/local/bin`, then you can run

```
$ fanocli --help
```

### Scaffolding project directory structure

To scaffold project structure using Fano framework, run with  `--create-project` command line options

```
$ fanocli --create-project=[another project name]
```

For example, following command will cause a new project created in directory name `test-fano` inside current directory.

```
$ fanocli --create-project=test-fano
```

This command line options creates Git repository and initial commit for you  automatically. This behavior may cause problem if you already create remote repository and try to merge local repository with remote one. Git may refuses
to merge because they have unrelated commit histories.

To workaround this problem, you can run `git merge` with option `--allow-unrelated-histories` or create project directory without creating initial commit or create project directory structure without
Git repository.

### Scaffolding project directory structure with Git without initial commit

To scaffold project structure using Fano framework with Git repository initialized but without creating initial commit, run with  `--create-project-no-commit` command line options

```
$ fanocli --create-project-no-commit=test-fano
```

This command line options is provided to enable you to commit Git repository manually. So you can merge local repository with a remote repository before
running git commit. After project directory is constructed, you need to execute following shell command,

```
$ cd test-fano
$ git commit -m "Initial commit"
```

### Scaffolding project directory structure without Git

To scaffold project structure using Fano framework but without initializing
Git repository, run with  `--create-project-without-git` command line options

```
$ fanocli --create-project-without-git=test-fano
```

This command line options is provided to enable you to initialize Git repository manually. After project directory is constructed, you need to execute following shell command,

```
$ cd test-fano
$ git init
$ git submodule add https://github.com/fanoframework/fano.git
$ git add .
$ git commit -m "Initial commit"
```

## Known Issues

### Issue with GNU Linker

When running `build.sh` script, you may encounter following warning:

```
/usr/bin/ld: warning: bin/out/link.res contains output sections; did you forget -T?
```

This is known issue between FreePascal and GNU Linker. See
[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)

However, this warning is minor and can be ignored. It does not affect output executable.

### Issue with unsynchronized compiled unit with unit source

Sometime FreePascal can not compile your code because, for example, you deleted a
unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there
or when you switch between git branches. Solution is to remove those files.

By default, generated compiled units are in `bin/unit` directory.
But do not delete `README.md` file inside this directory, as it is not being ignored by git.

```
$ rm bin/unit/*.ppu
$ rm bin/unit/*.o
$ rm bin/unit/*.rsj
$ rm bin/unit/*.a
```

Following shell command will remove all files inside `bin/unit` directory except
`README.md` file.

    $ find bin/unit ! -name 'README.md' -type f -exec rm -f {} +

`tools/clean.sh` script is provided to simplify this task. Following shell command is similar as command above.

    $ ./tools/clean.sh

### Windows user

Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace
compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to
become `-WC`.

### Lazarus user

While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.

## Contributing

Just create pull request if you have improvement you want to add.
