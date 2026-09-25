#!/usr/bin/env bash
set -euo pipefail
printf 'Task prompt: '
read -r prompt
[ -z "$prompt" ] && exit 0
/opt/homebrew/bin/workmux add --auto-name --prompt "$prompt" || { echo; echo "workmux add failed. Press any key to close."; read -n 1 -s; }
