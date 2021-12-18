all:
	cd ./scripts && python3 ./benchmark_plot.py
	mkdir -p build
	pdflatex -output-directory=build -synctex=1 -interaction=nonstopmode "paper".tex
	bibtex build/"paper".aux
	pdflatex -output-directory=build -synctex=1 -interaction=nonstopmode "paper".tex
	pdflatex -output-directory=build -synctex=1 -interaction=nonstopmode "paper".tex


clean:
	rm -rf build
	$(RM) *.log *.aux *.out *.bbl *.blg *.cut *.fdb_latexmk *.fls *.gz *.pdf
	$(RM) ./pictures/*.pdf


.PHONY: all clean
