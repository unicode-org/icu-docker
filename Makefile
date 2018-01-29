# © 2016 and later: Unicode, Inc. and others.
# License & terms of use: http://www.unicode.org/copyright.html

DIRS=tmp src tmp/.ccache dist

ICU_REPO=http://source.icu-project.org/repos/icu/trunk
BINPATH=/src/bin/
DISTROS=$(shell cd dockerfiles;ls)
DISTROS_SMALL=ubuntu fedora
SRC=src/icu
REV:=$(shell svnversion $(SRC) | tr -d ' ')
all:	dirs src/icu

#src/icu: src
#	if [ ! -f src/icu ]; then do cd src ; svn co $(ICU_REPO) icu; done

dirs:
	mkdir -p $(DIRS) tmp/.ccache
	chmod a+rwxt tmp/.ccache dist

dbuild: docker-compose.yml
	docker-compose build

build-all: all dbuild
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( docker-compose run $$distro bash $(BINPATH)/build.sh || exit 1); \
	done
	echo all OK

check-all: all dbuild
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	rm -f $$distro.fail ; \
	  ( docker-compose run $$distro bash $(BINPATH)/check.sh || (>$$distro.fail; exit 1)) >&1 | tee $$distro.out; \
	done
	echo all OK

check-some: all dbuild
	for distro in $(DISTROS_SMALL); do \
	  echo $$distro ; \
	rm -f $$distro.fail ; \
	  ( docker-compose run $$distro bash $(BINPATH)/check.sh || (>$$distro.fail; exit 1)) >&1 | tee $$distro.out; \
	done
	echo all OK

dist-all: all dbuild
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( docker-compose run $$distro env REV=$(REV) WHAT=$$distro /src/makedist.sh $$distro || exit 1); \
	done
	echo all OK

dist-some: all dbuild
	for distro in $(DISTROS_SMALL); do \
	  echo $$distro ; \
	  ( docker-compose run $$distro env REV=$(REV) WHAT=$$distro /src/makedist.sh $$distro || exit 1); \
	done
	echo all OK

dist: sdist dist-some

sdist: all dbuild
	for distro in $(firstword $(DISTROS_SMALL)); do \
	  echo $$distro ; \
	  ( docker-compose run $$distro env REV=$(REV) WHAT=$$distro /src/makesdoc.sh $$distro || exit 1); \
	done
	echo all OK

perf-all: all dbuild
	for distro in $(DISTROS); do \
	  echo $$distro ; \
	  ( docker-compose run $$distro bash $(BINPATH)/perf.sh $$distro || exit 1); \
	done
	echo all OK

.PHONY: all dirs build-all dbuild

pretest-run.pl:
	wget http://git.savannah.gnu.org/cgit/pretest.git/plain/pretest-run.pl



-include Makefile.local


