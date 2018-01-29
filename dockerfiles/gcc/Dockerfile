# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

# latest GCC!
FROM gcc:latest
MAINTAINER Steven R. Loomis <srl@icu-project.org>

USER root
ENV HOME /home/build
RUN useradd -c "Build user" -d $HOME -m build

# sanity and safety
# RUN apt-get -q -y update && apt-get -q -y upgrade
# RUN apt-get -q -y install make git subversion python g++ ccache valgrind doxygen zip curl wget
RUN mkdir /src /dist
VOLUME /src
VOLUME /dist
VOLUME /home/build
WORKDIR /home/build
# setup ccache
# RUN for comp in g++ gcc ld; do ln -sv `which ccache` /usr/local/bin/$comp; done
# icu-dev might get strange…
# RUN apt-get -q -y remove libicu-dev
# ENV LD_LIBRARY_PATH /usr/local/lib

USER build
