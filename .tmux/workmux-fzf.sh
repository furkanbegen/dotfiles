#!/usr/bin/env bash
# Usage: workmux-fzf.sh <open|remove|close>
# Fzf-pick a worktree and act on it.
set -uo pipefail

action="${1:-open}"

names=$(/opt/homebrew/bin/workmux list --json 2>/dev/null | /opt/homebrew/bin/jq -r '.[].handle')

if [ -z "$names" ]; then
  echo "No worktrees found."
  read -n 1 -s -r -p "Press any key to close..."
  exit 0
fi

selected=$(printf '%s\n' "$names" | fzf --prompt="${action}> " --header="Select worktree, Esc to cancel")

if [ -z "$selected" ]; then
  exit 0
fi

case "$action" in
  open)
    /opt/homebrew/bin/workmux open "$selected" || { echo; echo "workmux open failed. Press any key to close."; read -n 1 -s; }
    ;;
  remove)
    /opt/homebrew/bin/workmux remove "$selected" -f || echo "workmux remove failed."
    read -n 1 -s -r -p "Press any key to close..."
    ;;
  close)
    /opt/homebrew/bin/workmux close "$selected" || echo "workmux close failed."
    read -n 1 -s -r -p "Press any key to close..."
    ;;
  *)
    echo "Unknown action: $action"
    read -n 1 -s -r -p "Press any key to close..."
    ;;
esac
