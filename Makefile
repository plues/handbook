MARKDOWN=$(filter-out README.md,$(wildcard *.md))

default: handbook.pdf handbook.html
travis: handbook-1.9.0.html handbook-1.9.0.pdf

.PHONY: dependencies
dependencies:
	git submodule update --init

handbook-1.9.0.html:  $(MARKDOWN) dependencies
	pandoc -f markdown -t html --css=markdown-css-themes/markdown10.css \
		--standalone --self-contained $(MARKDOWN) -o $@

handbook.html: handbook-1.9.0.html
	cp $< $@

handbook-1.9.0.pdf: $(MARKDOWN)
	pandoc --standalone -f markdown -t latex $(MARKDOWN) -o $@

handbook.pdf: handbook-1.9.0.pdf
	cp $< $@

clean:
	rm -f handbook.pdf
	rm -f handbook.html
	rm -f handbook-*.html
	rm -f handbook-*.pdf

view: handbook.html
	open handbook.html
