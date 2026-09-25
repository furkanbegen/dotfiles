#!/usr/bin/env bash
# Pick an existing local/remote branch via fzf and create a worktree from it.
set -uo pipefail

branch=$(git branch -a --format='%(refname:short)' 2>/dev/null \
  | sed 's#^origin/##' \
  | grep -v '^HEAD$' \
  | sort -u \
  | fzf --prompt="branch> " --header="Select branch to check out, Esc to cancel")

if [ -z "$branch" ]; then
  exit 0
fi

/opt/homebrew/bin/workmux add "$branch" --open-if-exists || { echo; echo "workmux add failed. Press any key to close."; read -n 1 -s; }
