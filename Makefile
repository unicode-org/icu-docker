# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

DIRS=tmp src tmp/.ccache dist

ICU_REPO=http://source.icu-project.org/repos/icu/trunk
BINPATH=/src/bin/
# the 'full' list
DISTROS=$(shell cd dockerfiles;ls)
# the 'small' list. The first one is primary.
DISTROS_SMALL=ubuntu fedora
SRC=src/icu
REV:=$(shell (cd $(SRC) >/dev/null 2>/dev/null && (git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD)) || echo 'unknown')
#icu4c version
ICU4CVER:=$(shell ./$(BINPATH)/check-icu4c-version.sh  $(SRC)/icu4c )
DOCKERRUN=docker-compose run --rm
all:	dirs src/icu

#src/icu: src
#	if [ ! -f src/icu ]; then do cd src ; svn co $(ICU_REPO) icu; done

info:
	echo rev $(REV) cver $(ICU4CVER)

dirs:
	mkdir -p $(DIRS) tmp/.ccache
	chmod a+rwxt tmp/.ccache dist
	chmod -R o+rX src

dbuild: docker-compose.yml
	docker-compose build

build-all: all
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro bash $(BINPATH)/build.sh || exit 1); \
	done
	echo all OK $(ICU4CVER)

check-all: all 
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	rm -f $$distro.fail ; \
	  ( $(DOCKERRUN) $$distro bash $(BINPATH)/check.sh || (>$$distro.fail; exit 1)) >&1 | tee $$distro.out; \
	done
	echo all OK $(ICU4CVER)

check-some: all 
	for distro in $(DISTROS_SMALL); do \
	  echo $$distro ; \
	rm -f $$distro.fail ; \
	  ( $(DOCKERRUN) $$distro bash $(BINPATH)/check.sh || (>$$distro.fail; exit 1)) >&1 | tee $$distro.out; \
	done
	echo all OK $(ICU4CVER)

dist-all: all 
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro env REV=$(REV) WHAT=$$distro $(BINPATH)/makedist.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

dist-some: all 
	for distro in $(DISTROS_SMALL); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro env REV=$(REV) WHAT=$$distro $(BINPATH)/makedist.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

dist: sdist dist-some

# just source tarballs. A little more resilient to version changes.
src-some: all 
	for distro in $(DISTROS_SMALL); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro env REV=$(REV) WHAT=$$distro $(BINPATH)/makesrc.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

# just source tarballs. A little more resilient to version changes.
src-one: all 
	for distro in $(firstword $(DISTROS_SMALL)); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro env REV=$(REV) WHAT=$$distro $(BINPATH)/makesrc.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

sdist: all 
	for distro in $(firstword $(DISTROS_SMALL)); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro env REV=$(REV) WHAT=$$distro $(BINPATH)/makesdoc.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

perf-all: all 
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( $(DOCKERRUN) $$distro bash $(BINPATH)/perf.sh $$distro || exit 1); \
	done
	echo all OK $(ICU4CVER)

.PHONY: all dirs build-all dbuild

pretest-run.pl:
	wget http://git.savannah.gnu.org/cgit/pretest.git/plain/pretest-run.pl



-include Makefile.local


