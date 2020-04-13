.PHONY: docs tests readme helm-docs

MASTER_BRANCH=true
SOURCE_README=README.gotmpl
TARGET_README=README.md

docs: helm-docs readme

helm-docs:
		docker run --rm -v $$(pwd):/src -w /src -u $$(id -u) docker.io/jnorwood/helm-docs:v0.12.0

readme:
		go run readme.go $(SOURCE_README) $(TARGET_README) $(MASTER_BRANCH)

tests:
		find . -type f -name go.mod | cut -s -f 2,3 -d / - | xargs -I % sh -c "cd % && go test ./..."
