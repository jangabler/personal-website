HTML_FILES	:= $(patsubst %.phtml, dist/%.html, \
			   $(filter-out _%.phtml, \
			   $(notdir \
			   $(wildcard src/phtml/*.phtml))))

CSS_FILES	:= dist/styles/style.css

FONT_FILES	:= $(patsubst %, dist/fonts/%, \
			   $(notdir \
			   $(wildcard src/fonts/*)))

MISC_FILES	:= dist/.htaccess dist/robots.txt dist/sitemap.xml

.PHONY: all distclean installdirs build

all: distclean installdirs build

distclean:
	@rm -rf dist

installdirs:
	@mkdir dist dist/fonts dist/styles

build: $(HTML_FILES) $(CSS_FILES) $(FONT_FILES) $(MISC_FILES)

dist/%.html: src/phtml/%.phtml
	@php $< | tidy -config html-tidy-configuration-options.txt -o $@

dist/styles/%.css: src/scss/%.scss
	@sass --no-source-map $< $@

dist/fonts/%: src/fonts/%
	@cp $< $@

dist/%: src/misc/%
	@cp $< $@
