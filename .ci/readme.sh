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

pushd "${gh_pages_worktree}" > /dev/null

echo "Finding changed READMEs..."
if git diff --name-only --find-renames --exit-code HEAD; then
    echo "No READMEs to update."
else
    git add \*/README.md
    git commit --message="Update documentation" --signoff

    repo_url="https://x-access-token:$CR_TOKEN@github.com/$REPOSITORY"
    git push "$repo_url" gh-pages

    popd > /dev/null
fi
