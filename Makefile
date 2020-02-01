CMD_RM			:= rm -rf
CMD_MKDIR		:= mkdir -p
CMD_CP			:= cp
CMD_PHP			:= php
CMD_TIDY		:= tidy -config html-tidy-configuration-options.txt
CMD_SASS		:= sass --no-source-map

SRC_DIR			:= src
SRC_DIR_PHTML	:= $(SRC_DIR)/phtml
SRC_DIR_SCSS	:= $(SRC_DIR)/scss
SRC_DIR_FONTS	:= $(SRC_DIR)/fonts
SRC_DIR_MISC	:= $(SRC_DIR)/misc

DIST_DIR		:= dist
DIST_DIR_HTML	:= $(DIST_DIR)
DIST_DIR_CSS	:= $(DIST_DIR)/styles
DIST_DIR_FONTS	:= $(DIST_DIR)/fonts
DIST_DIR_MISC	:= $(DIST_DIR)

.PHONY: build

build:
	@$(CMD_RM) $(DIST_DIR)

	@$(CMD_MKDIR) $(DIST_DIR)
	@$(CMD_MKDIR) $(DIST_DIR_HTML)
	@$(CMD_MKDIR) $(DIST_DIR_CSS)
	@$(CMD_MKDIR) $(DIST_DIR_FONTS)
	@$(CMD_MKDIR) $(DIST_DIR_MISC)

	@$(CMD_PHP) $(SRC_DIR_PHTML)/index.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/index.html
	@$(CMD_PHP) $(SRC_DIR_PHTML)/privacy-policy.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/privacy-policy.html
	@$(CMD_PHP) $(SRC_DIR_PHTML)/colophon.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/colophon.html
	@$(CMD_PHP) $(SRC_DIR_PHTML)/403.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/403.html
	@$(CMD_PHP) $(SRC_DIR_PHTML)/404.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/404.html
	@$(CMD_PHP) $(SRC_DIR_PHTML)/500.phtml | \
	 $(CMD_TIDY) -o $(DIST_DIR_HTML)/500.html

	@$(CMD_SASS) $(SRC_DIR_SCSS)/style.scss $(DIST_DIR_CSS)/style.css

	@$(CMD_CP) $(SRC_DIR_FONTS)/{*.woff2,*.woff,*.ttf} $(DIST_DIR_FONTS)

	@$(CMD_CP) $(SRC_DIR_MISC)/{.htaccess,robots.txt} $(DIST_DIR_MISC)
