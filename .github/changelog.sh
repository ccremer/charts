#!/bin/bash

# Remove "refs/tags/"
tag="${GITHUB_REF##*/}"

# Remove SemVer at the end
chart=$(echo ${tag} | grep -P -o '^([a-zA-Z0-9-]+)(?![0-9.]+)')

tagPattern="${chart}-(.+)"
labelPattern='^(?!\\['${chart}'\\])'

echo "Tag search pattern: $tagPattern"
echo "Label search pattern: $labelPattern"

cat .github/changelog-configuration.json | jq '.tag_resolver.filter.pattern="'$tagPattern'" | .label_extractor[0].pattern="'$labelPattern'"' > .github/configuration.json
# cat .github/configuration.json
