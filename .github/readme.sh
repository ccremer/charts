#!/bin/bash
set -euo pipefail


gh_pages_worktree=$(mktemp -d)
git worktree add "${gh_pages_worktree}" gh-pages

copy_documentation() {
    while read chart; do
        [[ -d "${gh_pages_worktree}/${chart}" ]] || mkdir "${gh_pages_worktree}/${chart}"
        cp --force "charts/${chart}/README.md" "charts/${chart}/values.yaml" "${gh_pages_worktree}/${chart}/"
    done
}

find . -type f -name Chart.yaml | cut -s -f 3 -d / - | copy_documentation

make docs:readme TARGET_README="${gh_pages_worktree}/README.md" MASTER_BRANCH=false

pushd "${gh_pages_worktree}" > /dev/null

git add \*/README.md \*/values.yaml README.md

echo "Finding changes..."
if [[ -n "$(git status --porcelain)" ]]; then
    git commit --message="Update documentation" --signoff

    repo_url="https://x-access-token:$CR_TOKEN@github.com/$REPOSITORY"
    git push "$repo_url" gh-pages

else
    echo "No documentation to update."
fi
popd > /dev/null
