#
# Makefile for acmart package
#
# This file is in public domain
#
# $Id: Makefile,v 1.10 2016/04/14 21:55:57 boris Exp $
#

PACKAGE=acmart


PDF = $(PACKAGE).pdf acmguide.pdf

all:  ALLSAMPLES


%.pdf:  %.dtx   $(PACKAGE).cls
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done


acmguide.pdf: $(PACKAGE).dtx $(PACKAGE).cls
	pdflatex -jobname acmguide $(PACKAGE).dtx
	- bibtex acmguide
	pdflatex -jobname acmguide $(PACKAGE).dtx
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' acmguide.log) \
	do pdflatex -jobname acmguide $(PACKAGE).dtx; done

%.cls:   %.ins %.dtx
	pdflatex $<


ALLSAMPLES:
	cd proposal; cd ..
	for texfile in proposal/*.tex; do \
		pdffile=$${texfile%.tex}.pdf; \
		${MAKE} $$pdffile; \
	done

proposal/%: %
	cp $^ proposal


proposal/$(PACKAGE).cls: $(PACKAGE).cls
proposal/ACM-Reference-Format.bst: ACM-Reference-Format.bst

proposal/%.pdf:  proposal/%.tex   proposal/$(PACKAGE).cls proposal/ACM-Reference-Format.bst
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	- cd $(dir $@) && bibtex $(notdir $(basename $<))
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $(basename $<).log) \
	  do cd $(dir $@) && pdflatex-dev $(notdir $<); done



.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).cls

docclean:
	$(RM)  *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi \
	proposal/$(PACKAGE).cls proposal/ACM-Reference-Format.bst \
	proposal/*.log proposal/*.aux proposal/*.out \
	proposal/*.bbl proposal/*.blg proposal/*.cut \
	proposal/*.fdb_latexmk proposal/*.fls proposal/*.gz



clean: docclean
	$(RM)  $(PACKAGE).cls

distclean: clean
	$(RM)  *.pdf proposal/*.pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	COPYFILE_DISABLE=1 tar -C .. -czvf ../$(PACKAGE).tgz --exclude '*~' --exclude '*.tgz' --exclude '*.zip'  --exclude CVS --exclude '.git*' $(PACKAGE); mv ../$(PACKAGE).tgz .

zip:  all clean
	zip -r  $(PACKAGE).zip * -x '*~' -x '*.tgz' -x '*.zip' -x CVS -x 'CVS/*'

documents.zip: all docclean
	zip -r $@ acmart.pdf acmguide.pdf proposal *.cls ACM-Reference-Format.*

.PHONY: all ALLSAMPLES docclean clean distclean archive zip
