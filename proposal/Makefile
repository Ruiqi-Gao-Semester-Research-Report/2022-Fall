all:
	mkdir -p build
	for texfile in *.tex; do \
		pdffile=$${texfile%.tex}.pdf; \
		${MAKE} $$pdffile; \
	done

%.pdf:  %.tex
	cd $(dir $@) && pdflatex-dev --output-directory=build $(notdir $<)
	- cd $(dir $@) && bibtex --output-directory=build $(notdir $(basename $<))
	cd $(dir $@) && pdflatex-dev --output-directory=build $(notdir $<)
	cd $(dir $@) && pdflatex-dev --output-directory=build $(notdir $<)
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' build/$(basename $<).log) \
	  do cd $(dir $@) && pdflatex-dev --output-directory=build $(notdir $<); done



clean:
	rm -rf build
	$(RM) *.log *.aux *.out *.bbl *.blg *.cut *.fdb_latexmk *.fls *.gz *.pdf


.PHONY: all clean
