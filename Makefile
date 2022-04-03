# This Makefile provides sensible defaults for projects
# based on Pandoc and Jekyll, such as:
# - Dockerized runs of Pandoc and Jekyll with separate
#   variables for version numbers = easy update!
# - Lean CSL checkouts without committing to the repo
# - Website built on the gh-pages branch
# - Bibliography path compatible with Jekyll-Scholar

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
	$(PANDOC/LATEX) -d _spec/latex -o $@ $<
	@echo "$< > $@"

%.docx : %.md $(DEFAULTS) docx.yaml reference.docx biblio.yaml
	$(PANDOC/CROSSREF) -d _spec/docx -o $@ $<
	@echo "$< > $@"

# vim: set foldmethod=marker shiftwidth=2 tabstop=2 :
