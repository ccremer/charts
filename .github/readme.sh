#!/bin/bash
set -euo pipefail


gh_pages_worktree=$(mktemp -d)
git worktree add "${gh_pages_worktree}" gh-pages

copy_documentation() {
    while read chart; do
        [[ -d "${gh_pages_worktree}/charts/${chart}" ]] || mkdir -p "${gh_pages_worktree}/charts/${chart}"
        cp --force "charts/${chart}/README.md" "${gh_pages_worktree}/charts/${chart}/README.md"
    done
}

find . -type f -name Chart.yaml | cut -s -f 3 -d / - | copy_documentation

make readme TARGET_README="${gh_pages_worktree}/README.md" MASTER_BRANCH=false

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
