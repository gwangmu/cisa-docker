# Docker environment for [CISA](https://github.com/gwangmu/cisa)

## Setup

 1. Install `docker`.
 2. Make a CISA docker image.
```
$ make
```

## General Usage

`cisa` accepts the same argument as `cisa` from the original CISA (except `-x`. See below).


## Development

### Setting up a build environment

Use `make up` to incrementally set up a project-specific build environment. Below are the accepted Makefile environment variables.
 * `BUILD_TOOLS`: space-separated list. List of build tools (e.g., `autoconf`) to install.
 * `RECONF_PATH`: path to a clean and reconfigure command snippet.

### Uploading custom analyses

`make up` also copies all custom analyses in `analysis` to CISA and rebuilds it.
