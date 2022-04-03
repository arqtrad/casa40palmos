# Global variables and setup {{{1
# ================
VPATH = _lib
vpath %.yaml . _spec _data
vpath default.% . _lib

PANDOC-VERSION := 2.17.1.1
PANDOC/LATEX := docker run --rm -v "`pwd`:/data" \
	-u "`id -u`:`id -g`" pandoc/latex:$(PANDOC-VERSION)

# Targets and recipes {{{1
# ===================
%.pdf : %.md biblio.yaml latex.yaml
	docker run --rm -v "`pwd`:/data" \
	-u "`id -u`:`id -g`" pandoc/latex:$(PANDOC-VERSION) \
  -d _spec/latex -o $@ $<
	@echo "$< > $@"

%.docx : %.md $(DEFAULTS) docx.yaml reference.docx biblio.yaml
	docker run --rm -v "`pwd`:/data" \
	-u "`id -u`:`id -g`" pandoc/core:$(PANDOC-VERSION) \
	-d _spec/docx -o $@ $<
	@echo "$< > $@"

# vim: set foldmethod=marker shiftwidth=2 tabstop=2 :
