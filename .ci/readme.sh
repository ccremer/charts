#!/bin/bash
set -euo pipefail


gh_pages_worktree=$(mktemp -d)
git worktree add "${gh_pages_worktree}" gh-pages

copy_documentation() {
    while read chart; do
        [[ -d "${gh_pages_worktree}/${chart}" ]] || mkdir "${gh_pages_worktree}/${chart}"
        cp --force "${chart}/README.md" "${gh_pages_worktree}/${chart}/README.md"
    done
}

find . -type f -name Chart.yaml | cut -s -f 2 -d / - | copy_documentation

# Copy root README
cp --force "README.md" "${gh_pages_worktree}/README.md"

pushd "${gh_pages_worktree}" > /dev/null

git add \*/README.md
git add README.md

echo "Finding changed READMEs..."
if [[ -n "$(git status --porcelain)" ]]; then
    git commit --message="Update documentation" --signoff

    repo_url="https://x-access-token:$CR_TOKEN@github.com/$REPOSITORY"
    git push "$repo_url" gh-pages

else
    echo "No READMEs to update."
fi
popd > /dev/null
