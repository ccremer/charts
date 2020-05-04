.PHONY: docs bump-docs tests readme helm-docs bump bump-patch bump-minor bump-major

MASTER_BRANCH=true
SOURCE_README=README.gotmpl
TARGET_README=README.md

bump_cmd := git diff --exit-code --name-only | cut -d "/" -f 1 | uniq | xargs -L 1 go run bump.go
bump_echo := echo --- Bumping chart versions

docs: helm-docs readme

bump-docs: bump helm-docs readme

helm-docs:
	@echo --- Generating Chart READMEs
	@docker run --rm -v $$(pwd):/helm-docs -u $$(id -u) docker.io/jnorwood/helm-docs:v0.13.0

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
	@$(bump_cmd) patch

tests:
	@echo --- Executing unit tests
	@find . -type f -name go.mod | cut -s -f 2,3 -d / - | xargs -I % sh -c "cd % && go test ./..."
