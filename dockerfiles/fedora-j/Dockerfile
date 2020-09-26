# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

FROM registry.fedoraproject.org/fedora:latest
MAINTAINER Steven R. Loomis <srl@icu-project.org>

USER root
ENV HOME /home/build
RUN useradd -c "Build user" -d $HOME -m build
#ENV RPMOPTZ --setopt=deltarpm=false
# sanity and safety
RUN dnf -q -y upgrade $RPMOPTZ
ADD adoptopenjdk.repo /etc/yum.repos.d
RUN dnf -q -y install adoptopenjdk-8-openj9 $RPMOPTZ
RUN dnf -q -y install ant $RPMOPTZ
RUN dnf -q -y install git curl maven gpg $RPMOPTZ
#extra
# editing
#RUN apt-get -q -y install emacs24-nox
RUN mkdir /src /dist
VOLUME /src
VOLUME /dist
VOLUME /home/build
WORKDIR /home/build
USER build
ENV JAVA_HOME /usr/lib/jvm/adoptopenjdk-8-openj9/
WORKDIR /src/icu/icu4j

