FROM alpine:latest

USER root
ENV HOME /home/build

RUN apk --update add gcc make python g++ ccache valgrind doxygen tar zip curl wget git bash
RUN addgroup build && adduser -g "Build user" -h $HOME -S -G build -D -s /bin/sh build

RUN mkdir /src /dist
VOLUME /src
VOLUME /dist
VOLUME /home/build
WORKDIR /home/build
USER build

