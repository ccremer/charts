#!/bin/bash
set -euo pipefail


gh_pages_worktree=$(mktemp -d)
git worktree add "$gh_pages_worktree" gh-pages

find . -type f -name Chart.yaml | \
cut -s -f 2 -d / - | \
xargs -I % cp --force "%/README.md" "$gh_pages_worktree/%/README.md"

pushd "$gh_pages_worktree" > /dev/null

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
