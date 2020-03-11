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

- optional: symlink `src/` to `/src` on your system

this will make error messages work

     sudo ln -sv `pwd`/{src,dist} /

- do some command line builds

```
    $ docker-compose run ubuntu bash
    build@59b67f6c5058:~$ /src/icu/icu4c/source/configure
    checking for ICU version numbers...
```

## Author

Steven R. Loomis

## License

ICU license, see [LICENSE](LICENSE)
