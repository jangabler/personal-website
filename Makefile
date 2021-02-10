include secrets.mk

HTML_FILES	:= $(patsubst %.phtml, dist/%.html, \
			   $(filter-out _%.phtml, \
			   $(notdir \
			   $(wildcard src/phtml/*.phtml))))

CSS_FILES	:= dist/styles/style.css

FONT_FILES	:= $(patsubst %, dist/fonts/%, \
			   $(notdir \
			   $(wildcard src/fonts/*)))

IMG_FILES	:= $(addprefix dist/img/, \
			   $(notdir \
			   $(wildcard src/img/*)))

MISC_FILES	:= dist/.htaccess dist/robots.txt dist/sitemap.xml

.PHONY: all distclean installdirs build deploy serve

all: distclean installdirs build

distclean:
	@rm -rf dist

installdirs:
	@mkdir -p dist/{styles,fonts,img}

build: $(HTML_FILES) $(CSS_FILES) $(FONT_FILES) $(IMG_FILES) $(MISC_FILES)

dist/%.html: src/phtml/%.phtml
	@php $< | tidy -config html-tidy-configuration-options.txt -o $@

dist/styles/%.css: src/scss/%.scss
	@sass --no-source-map $< $@

dist/fonts/%: src/fonts/%
	@cp $< $@

dist/img/%.png: src/img/%.png
	@cp $< $@
	@cwebp $< -quiet -o $(basename $@).webp

dist/img/%.svg: src/img/%.svg
	@cp $< $@

dist/%: src/misc/%
	@cp $< $@

deploy:
	@sftp $(SFTP_USERNAME)@$(SFTP_HOSTNAME):$(SFTP_DIRECTORY)

serve:
	@docker build -t jangabler/personal-website .
	@docker run -dit -p 80:80 jangabler/personal-website
