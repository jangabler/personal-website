SRC_DIR			:= src
SRC_DIR_HTML	:= $(SRC_DIR)/html
SRC_DIR_STYLES	:= $(SRC_DIR)/styles
SRC_DIR_FONTS	:= $(SRC_DIR)/fonts
SRC_DIR_MISC	:= $(SRC_DIR)/misc

DIST_DIR		:= dist
DIST_DIR_HTML	:= $(DIST_DIR)
DIST_DIR_STYLES	:= $(DIST_DIR)/styles
DIST_DIR_FONTS	:= $(DIST_DIR)/fonts
DIST_DIR_MISC	:= $(DIST_DIR)

.PHONY: build

build:
	@rm -rf $(DIST_DIR)

	@mkdir -p $(DIST_DIR)
	@mkdir -p $(DIST_DIR_HTML)
	@mkdir -p $(DIST_DIR_STYLES)
	@mkdir -p $(DIST_DIR_FONTS)
	@mkdir -p $(DIST_DIR_MISC)

	@cp $(SRC_DIR_HTML)/*.html $(DIST_DIR_HTML)

	@sass --no-source-map \
		$(SRC_DIR_STYLES)/style.scss $(DIST_DIR_STYLES)/style.css

	@cp $(SRC_DIR_FONTS)/{*.woff2,*.woff,*.ttf} $(DIST_DIR_FONTS)

	@cp $(SRC_DIR_MISC)/{.htaccess,robots.txt} $(DIST_DIR_MISC)
