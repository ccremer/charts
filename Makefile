SHELL := /usr/bin/env bash

MAKEFLAGS += --warn-undefined-variables
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:

MASTER_BRANCH=master
SOURCE_README=README.gotmpl
TARGET_README=README.md
CHARTS_DIR=charts/

.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = "(: ).*?## "}; {gsub(/\\:/,":",$$1)}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: docs
docs: docs\:helm docs\:readme

.PHONY: docs\:helm
docs\:helm: ## Creates the Chart READMEs from template and values.yaml files
	@echo --- Generating Chart READMEs
	@docker run --rm -v $$(pwd):/helm-docs -u $$(id -u) jnorwood/helm-docs:v1.5.0 \
		--template-files ./.github/helm-docs-header.gotmpl.md \
		--template-files README.gotmpl.md \
		--template-files ./.github/helm-docs-footer.gotmpl.md

.PHONY: docs\:readme
docs\:readme: ## Creates the root README from template
	@go run readme.go $(SOURCE_README) $(TARGET_README) $(MASTER_BRANCH) $(CHARTS_DIR)

.PHONY: test
test: ## Run Chart unit tests
	@echo --- Executing unit tests
	@go test ./...

.PHONY: lint\:fmt
lint\:fmt: ## Run go fmt against code
	go fmt ./...

.PHONY: lint\:vet
lint\:vet: ## Run go vet against code
	go vet ./...

.PHONY: lint
lint: lint\:fmt lint\:vet ## Invokes the fmt, vet and checks for uncommitted changes
	@echo 'Check for uncommitted changes ...'
	git diff --exit-code

.PHONY: lint\:versions
lint\:versions: ## Checks if chart versions have been changed
	@echo --- Detecting version bumps in the charts
	@echo "    If this target fails, one of the listed charts below has not its version updated!"
	@changed_charts=$$(git diff --dirstat=files,0 origin/master..HEAD -- charts | cut -d '/' -f 2 | uniq) ; \
	  echo "Charts changed: $$changed_charts" ; echo ;  \
	  for dir in $$changed_charts; do git diff origin/master..HEAD -- "charts/$${dir}/Chart.yaml" | grep -H --label=$${dir} "+version"; done

.PHONY: prepare
prepare: ## Prepare the charts for testing
	@echo --- Preparing charts
	@find charts -type f -name Makefile | sed 's|/[^/]*$$||' | xargs -I '%' make -C '%' prepare
	@echo 'Check for uncommitted changes ...'
	git diff --exit-code
