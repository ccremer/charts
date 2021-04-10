SHELL := /usr/bin/env bash

MASTER_BRANCH=master
SOURCE_README=README.gotmpl
TARGET_README=README.md

bump_cmd := git diff HEAD~1..HEAD --name-only | cut -d "/" -f 1 | uniq | xargs -L 1 go run bump.go
bump_echo := echo --- Bumping chart versions

.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = "(: ).*?## "}; {gsub(/\\:/,":",$$1)}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: docs
docs: helm-docs readme

.PHONY: bump-docs
bump-docs: bump helm-docs readme

.PHONY: helm-docs
helm-docs:
	@echo --- Generating Chart READMEs
	@docker run --rm -v $$(pwd):/helm-docs -u $$(id -u) jnorwood/helm-docs:v1.4.0 \
		--template-files ./.github/helm-docs-header.gotmpl.md \
		--template-files README.gotmpl.md \
		--template-files ./.github/helm-docs-footer.gotmpl.md

.PHONY: readme
readme:
	@go run readme.go $(SOURCE_README) $(TARGET_README) $(MASTER_BRANCH)

.PHONY: bump
bump: bump-patch

.PHONY: bump-major
bump-major:
	@${bump_echo}
	@$(bump_cmd) major

.PHONY: bump-minor
bump-minor:
	@${bump_echo}
	@$(bump_cmd) minor

.PHONY: bump-patch
bump-patch:
	@${bump_echo}
	$(bump_cmd) patch

.PHONY: tests
tests:
	@echo --- Executing unit tests
	@go test ./...

.PHONY: fmt
fmt: ## Run go fmt against code
	go fmt ./...

.PHONY: vet
vet: ## Run go vet against code
	go vet ./...

.PHONY: lint
lint: fmt vet lint-yaml ## Invokes the fmt, vet and checks for uncommitted changes
	@echo 'Check for uncommitted changes ...'
	git diff --exit-code

.PHONY: lint-yaml
lint-yaml:
	@docker run --rm $$(tty -s && echo "-it" || echo) -u $$(id -u) -v $(PWD):/data cytopia/yamllint:1.20 .
