MD_FILES  := kmartBayesian.md
PDF_FILES := $(MD_FILES:.md=.pdf)

all: pdf

pdf: $(PDF_FILES)

%.pdf: %.md
	pandoc -N -V papersize:a4paper -V fontsize=12pt -V geometry:margin=2cm $< -o $@

clean:
	rm -f $(PDF_FILES)

.PHONY: all pdf clean
