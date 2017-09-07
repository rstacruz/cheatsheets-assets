host := https://ricostacruz.com/cheatsheets
sheets := react react@0.14
images := $(patsubst %,previews/%.jpg,$(sheets))
ifeq ($(DRYRUN),1)
	do := echo
else
	do :=
endif

-include Makefile.deps

all: SANITY previews/index.jpg PREVIEWS TIMESTAMP DONE

SANITY:
	@if [ ! -e _cheatsheets/.git ]; then echo "Please put cheatsheets repo into ./_cheatsheets"; exit 1; fi
	@if [ ! -e _support/getimage/node_modules ]; then cd _support/get_image/; yarn; fi

TIMESTAMP:
	@date +"%Y-%m-%d" > _updated.txt

DONE:
	@echo "=> Done."

previews/%.jpg:
	@echo ""
	@echo == $@
	@mkdir -p _tmp
	@# Retrieve screenshot
	@$(do) ./_support/getimage/bin/getimage \
		"$(host)/$(patsubst previews/%.jpg,%,$@)?preview=1" \
		--output "$(patsubst previews/%.jpg,_tmp/%.png,$@)"
	@# Convert to jpg
	@$(do) convert $(patsubst previews/%.jpg,_tmp/%.png,$@) \
		-resize 900x \
		-quality 90 \
		$@

# Updates Makefile.deps
update_deps:
	@bash _support/fetch_log/fetch_log.sh > Makefile.deps
	@echo "=> Updated Makefile.deps:"
	@cat Makefile.deps

.PHONY: PREVIEWS all SANITY TIMESTAMP DONE
