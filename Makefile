########################################################################
# Makefile for installing SGMLS.pm and associated files in Unix
# or Unix-like environments.  You should check the values of the
# variables at the beginning and change them as appropriate.
#
# Version: 1.03
########################################################################

#
# Beginning of user options.
#

# Where is the binary for perl5 located on your system?
PERL = /usr/bin/perl

# Where do you want the sgmlspl executable script to be installed?
BINDIR = /usr/local/bin

# Where do you put local perl5 libaries?
PERL5DIR = /usr/local/lib/perl5
MODULEDIR = ${PERL5DIR}/SGMLS

# Where do you want to put sgmlspl specifications?
SPECDIR = ${PERL5DIR}

# If you plan to install the HTML version of the documentation, where
# do you intend to put it?  'make html' will create two
# subdirectories, ${HTMLDIR}/SGMLSpm and ${HTMLDIR}/sgmlspl, and place
# its files there.
HTMLDIR = /usr/local/lib/www/docs


#
# End of user options.
#

HTML_SOURCES = DOC/HTML/SGMLSpm/ DOC/HTML/sgmlspl/

FILES =	${BINDIR}/sgmlspl \
	${PERL5DIR}/SGMLS.pm \
	${MODULEDIR}/Output.pm \
	${MODULEDIR}/Refs.pm \
	${SPECDIR}/skel.pl

all: install docs

install: install_system # install_html

install_system: ${MODULEDIR} ${FILES}

dist: SGMLSpm-1.03.tar.gz

${BINDIR}/sgmlspl: sgmlspl.pl
	sed -e 's!/usr/bin/perl!${PERL}!' sgmlspl.pl > ${BINDIR}/sgmlspl
	chmod a+x,a+r ${BINDIR}/sgmlspl

${PERL5DIR}/SGMLS.pm: SGMLS.pm
	cp SGMLS.pm ${PERL5DIR}/SGMLS.pm
	chmod a+r ${PERL5DIR}/SGMLS.pm

${MODULEDIR}:
	if [ ! -d ${MODULEDIR} ]; then\
	  mkdir ${MODULEDIR}; \
	  chmod a+x ${MODULEDIR}; \
	fi

${MODULEDIR}/Output.pm: Output.pm
	cp Output.pm ${MODULEDIR}/Output.pm
	chmod a+r ${MODULEDIR}/Output.pm

${MODULEDIR}/Refs.pm: Refs.pm
	cp Refs.pm ${MODULEDIR}/Refs.pm
	chmod a+r ${MODULEDIR}/Refs.pm

${SPECDIR}/skel.pl: skel.pl
	cp skel.pl ${SPECDIR}/skel.pl
	chmod a+r ${SPECDIR}/skel.pl

install_html: ${HTML_SOURCES}
	cd DOC; make html
	rm -rf ${HTMLDIR}/SGMLSpm ${HTMLDIR}/sgmlspl
	cp -r ${HTML_SOURCES} ${HTMLDIR}
	chmod a+x,a+r ${HTMLDIR}/SGMLSpm ${HTMLDIR}/sgmlspl
	chmod a+r ${HTMLDIR}/SGMLSpm/* ${HTMLDIR}/sgmlspl/*

docs:
	cd DOC; make all

SGMLSpm-1.03.tar.gz: clean docs
	cd ..; \
	tar -c -v -z --exclude RCS -f /tmp/SGMLSpm-1.03.tar.gz SGMLSpm; \
	mv /tmp/SGMLSpm-1.03.tar.gz SGMLSpm

clean:
	cd DOC; make clean
	rm -f *~ core *.tar *.tar.gz
