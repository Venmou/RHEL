title = 'Modern C++ Tutorial: C++11/14/17/20 On the Fly'
filename = 'modern-cpp-tutorial'
outputname='modern-cpp-tutorial'
revision = $(shell git describe --always --tags)

all: revision pdf

revision:
	@echo '% Autogenerated, do not edit' > revision.tex
	@echo '\\newcommand{\\revision}{'$(revision)'}' >> revision.tex

pdf: markdown
	@echo "Compiling PDF file..."
	pandoc -f markdown+smart -s $(filename).md -o $(filename).pdf \
		--title-prefix $(title) \
		--template=meta/template.tex \
		--pdf-engine=`which xelatex`
	@echo "Done."
	rm *.md revision.tex

markdown:
	@echo "Copy markdown files..."
	cp -r ../../book/en-us/* .
	@echo "Aggregating markdown files..."
	python3 aggregator.py

clean:
	rm -rf revision.tex *.md

.PHONY: markdown pdf clean