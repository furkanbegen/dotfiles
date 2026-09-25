#!/usr/bin/env bash
set -euo pipefail
printf 'Branch: '
read -r branch
[ -z "$branch" ] && exit 0
/opt/homebrew/bin/workmux add "$branch" || { echo; echo "workmux add failed. Press any key to close."; read -n 1 -s; }
