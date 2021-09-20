all:
	cd proposal; cd ..
	for texfile in proposal/*.tex; do \
		pdffile=$${texfile%.tex}.pdf; \
		${MAKE} $$pdffile; \
	done


proposal/%.pdf:  proposal/%.tex
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	- cd $(dir $@) && bibtex $(notdir $(basename $<))
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	cd $(dir $@) && pdflatex-dev $(notdir $<)
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $(basename $<).log) \
	  do cd $(dir $@) && pdflatex-dev $(notdir $<); done



clean:
	$(RM)	proposal/*.log proposal/*.aux proposal/*.out \
			proposal/*.bbl proposal/*.blg proposal/*.cut \
			proposal/*.fdb_latexmk proposal/*.fls proposal/*.gz


pdfclean: clean
	$(RM)  proposal/*.pdf


.PHONY: all clean pdfclean
