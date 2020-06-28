.PHONY: docs bump-docs tests readme helm-docs bump bump-patch bump-minor bump-major fmt lint-yaml
SHELL := /usr/bin/env bash

MASTER_BRANCH=master
SOURCE_README=README.gotmpl
TARGET_README=README.md

bump_cmd := git diff --name-only | cut -d "/" -f 1 | uniq | xargs -L 1 go run bump.go
bump_echo := echo --- Bumping chart versions

docs: helm-docs readme

bump-docs: bump helm-docs readme

helm-docs:
	@echo --- Generating Chart READMEs
	@docker run --rm -v $$(pwd):/helm-docs -u $$(id -u) jnorwood/helm-docs:v0.13.0

readme:
	@go run readme.go $(SOURCE_README) $(TARGET_README) $(MASTER_BRANCH)

bump: bump-patch

bump-major:
	@${bump_echo}
	@$(bump_cmd) major

bump-minor:
	@${bump_echo}
	@$(bump_cmd) minor

bump-patch:
	@${bump_echo}
	$(bump_cmd) patch

tests:
	@echo --- Executing unit tests
	@find . -type f -name go.mod | cut -s -f 2,3 -d / - | xargs -I % sh -c "cd % && echo % && go test ./..."

fmt:
	@[[ -z $$(go fmt ./...) ]]

lint-yaml:
	@docker run --rm $$(tty -s && echo "-it" || echo) -u $$(id -u) -v $(PWD):/data cytopia/yamllint:1.20 .
