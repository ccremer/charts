.PHONY: docs bump-docs tests readme helm-docs bump bump-patch bump-minor bump-major

MASTER_BRANCH=true
SOURCE_README=README.gotmpl
TARGET_README=README.md

docs: helm-docs readme

bump-docs: bump helm-docs readme

helm-docs:
	docker run --rm -v $$(pwd):/src -w /src -u $$(id -u) docker.io/jnorwood/helm-docs:v0.12.0

readme:
	go run readme.go $(SOURCE_README) $(TARGET_README) $(MASTER_BRANCH)

bump: bump-patch

bump-major:
	git diff --exit-code --name-only | while read file; do dirname $$file; done | uniq | xargs -L 1 go run bump.go major

bump-minor:
	git diff --exit-code --name-only | while read file; do dirname $$file; done | uniq | xargs -L 1 go run bump.go minor

bump-patch:
	git diff --exit-code --name-only | while read file; do dirname $$file; done | uniq | xargs -L 1 go run bump.go patch

tests:
	find . -type f -name go.mod | cut -s -f 2,3 -d / - | xargs -I % sh -c "cd % && go test ./..."
