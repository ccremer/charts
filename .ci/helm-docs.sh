#!/bin/bash
set -euo pipefail

HELM_DOCS_VERSION="v0.12.0"

# validate docs
docker run --rm -v $(pwd):/src -w /src -u $(id -u) jnorwood/helm-docs:${HELM_DOCS_VERSION}
git diff --exit-code
