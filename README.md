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
````
    cd src
    git clone --branch master --depth 1 https://github.com/unicode-org/icu.git
    cd icu
    git lfs fetch
    git lfs checkout
    cd ../..
````
- run tests
````
     make check-all
````
- build binaries
````
    make dist
````         
- sort into dist/icu4c-*/*

  The files should include the version label such as "69rc" for the release candidate of ICU version 69. The general availability for that woud be "69.1". 
````
     ./sort-out-dist.sh
     ls -l dist/icu4c-*
````
- optional: symlink `src/` to `/src` on your system

This symlink will make error messages from inside the container usable on your local system, of the form: `Error in /src/icu/somefile.cpp`.
````
     sudo ln -sv `pwd`/{src,dist} /
````

- Perform some command line builds to verify the release.
```
    $ docker-compose run ubuntu bash
    # This creates a temporary docker shell with a name such as 'build@671f33b0fe95:~'
    build@59b67f6c5058:~$ /src/icu/icu4c/source/configure
    # This will show the ICU version number of the release just created.

    build@59b67f6c5058:~$ make check  # To run all ICU4C tests
    ...
    build@59b67f6c5058:~$ exit  # To leave the docker shell
    
```

## Author

Steven R. Loomis

## License

ICU license, see [LICENSE](LICENSE)
