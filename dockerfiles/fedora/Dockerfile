# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

FROM registry.fedoraproject.org/fedora:latest
MAINTAINER Steven R. Loomis <srl@icu-project.org>

USER root
ENV HOME /home/build
RUN useradd -c "Build user" -d $HOME -m build
#ENV RPMOPTZ --setopt=deltarpm=false
# sanity and safety
RUN dnf -q -y upgrade $RPMOPTZ && dnf -q -y install make git subversion python gcc-c++ ccache valgrind doxygen tar zip curl wget $RPMOPTZ
#extra
# editing
#RUN apt-get -q -y install emacs24-nox
RUN mkdir /src /dist
VOLUME /src
VOLUME /dist
VOLUME /home/build
WORKDIR /home/build
USER build
