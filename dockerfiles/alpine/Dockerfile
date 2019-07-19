FROM alpine:latest

USER root
ENV HOME /home/build
#RUN useradd -c "Build user" -d $HOME -m build

RUN apk --update add gcc make python g++ ccache valgrind doxygen tar zip curl wget git bash

RUN mkdir /src /dist
VOLUME /src
VOLUME /dist
VOLUME /home/build
WORKDIR /home/build
#USER build

