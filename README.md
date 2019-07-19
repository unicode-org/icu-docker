# icu-dev

> ICU development inside Docker

This is a set of dockerfiles and a Makefile to develop with ICU (against Ubuntu, Fedora, anything else you can run from docker).
It sets up `ccache` to share cached compiler output in `./tmp/.ccache` and expects an ICU source directory under `./src/icu`


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

- just build tarballs (can work on older releases)

     make src-one

## Author

Steven R. Loomis

## License

ICU license, see [LICENSE](LICENSE)
