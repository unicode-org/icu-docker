# icu-dev

> ICU development inside Docker

This is a set of dockerfiles and a Makefile to develop with ICU (against Ubuntu, Fedora, anything else you can run from docker).
It sets up `ccache` to share cached compiler output in `./tmp/.ccache` and expects an ICU source directory under `./src/icu`

## Customization

You can create a `Makefile.local` that can point to a different docker-compose.yaml:

```
# Makefile.local
DOCKER_COMPOSE=docker-compose -f local-docker-compose.yml
```

## Usage

- install [Docker](http://docker.io)
- bring in ICU source

     cd src
     git clone --branch master --depth 1 https://github.com/unicode-org/icu.git
     cd icu
     git lfs fetch
     git lfs checkout
     cd ../..

- run tests

     make check-all

- build binaries

     make dist
     # sort into dist/icu4c-66.1/*
     ./sort-out-dist.sh
     ls -l dist/icu4c-*

- optional: symlink `src/` to `/src` on your system

this will make error messages work

     sudo ln -sv `pwd`/{src,dist} /

- do some command line builds

```shell
    $ docker-compose run ubuntu bash
    build@59b67f6c5058:~$ /src/icu/icu4c/source/configure
    checking for ICU version numbers...
```

## Coverity Scan

https://scan.coverity.com/

- download the scanning tools and install them as `src/bin/cov-analysis-linux64/`
(you can unpack the .tgz in src/bin and create a symlink)

- create an executable script file named `src/bin/local-coverity.sh` with
the following contents: (see the coverity page for the project for more details)

```shell
export PROJ=icu4c
export COVERITY_TOKEN=yourtoken
export COVERITY_EMAIL=email@example.com
```

- Kick it off: `docker-compose run ubuntu /src/bin/cov-icu4c.sh`

Note: you may want to do `docker-compose run ubuntu` and then run the script from the command line
if there are problems.

## ICU4J

- the following will build (in-source!) using adoptopenjdk9

```shell
docker-compose run fedora-j ant jar check
```

## Author

Steven R. Loomis

## License

ICU license, see [LICENSE](LICENSE)
