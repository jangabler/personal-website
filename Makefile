SRC_DIR			:= src
SRC_HTML_DIR	:= $(SRC_DIR)/html
SRC_STYLES_DIR	:= $(SRC_DIR)/styles
SRC_FONTS_DIR	:= $(SRC_DIR)/fonts
SRC_MISC_DIR	:= $(SRC_DIR)/misc

DIST_DIR		:= dist
DIST_HTML_DIR	:= $(DIST_DIR)
DIST_STYLES_DIR	:= $(DIST_DIR)/styles
DIST_FONTS_DIR	:= $(DIST_DIR)/fonts
DIST_MISC_DIR	:= $(DIST_DIR)

.PHONY: build

build:
	@rm -rf $(DIST_DIR)

	@mkdir -p $(DIST_DIR)
	@mkdir -p $(DIST_HTML_DIR)
	@mkdir -p $(DIST_STYLES_DIR)
	@mkdir -p $(DIST_FONTS_DIR)
	@mkdir -p $(DIST_MISC_DIR)

	@cp $(SRC_HTML_DIR)/*.html $(DIST_HTML_DIR)

	@sass --no-source-map \
		$(SRC_STYLES_DIR)/style.scss $(DIST_STYLES_DIR)/style.css

	@cp $(SRC_FONTS_DIR)/{*.woff2,*.woff,*.ttf} $(DIST_FONTS_DIR)

	@cp $(SRC_MISC_DIR)/{.htaccess,robots.txt} $(DIST_MISC_DIR)
