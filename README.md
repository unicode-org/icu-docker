# icu-dev

> ICU development inside Docker

## Usage

- install [Docker](http://docker.io)
- bring in ICU source

     # Option A: svn checkout
     svn co http://source.icu-project.org/repos/icu/trunk src/icu
     # Option B: symlink
     ln -s ~/src/icu ./src/icu

- run tests

     make check-all

- build binaries

     make dist

- optional: symlink `src/` to `/src` on your system

this will make error messages work

     sudo ln -sv `pwd`{src,dist} /

## Author

Steven R. Loomis

## License

ICU license, see [LICENSE](LICENSE)
