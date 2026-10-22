#!/bin/sh
# Agent notification → Ghostty native desktop notification (OSC 777), via tmux passthrough.
# Usage: agent-notify.sh <done|waiting> <agent>
# Requires tmux: set -g allow-passthrough all
# Inner OSC is BEL-terminated because a trailing ESC-ST inside the tmux DCS
# wrapper gets mangled and silently dropped.
# Proven pattern: https://gist.github.com/scarrillo/1668e3213a6066c9bda680a3e27be231

status="${1:-done}"
agent="${2:-agent}"

# Skip when the agent's tmux window is already focused.
if [ -n "$TMUX_PANE" ]; then
  active="$(tmux display-message -p -t "$TMUX_PANE" '#{window_active}' 2>/dev/null)"
  [ "$active" = "1" ] && exit 0
fi

case "$status" in
  done)    title="$agent — finished";     body="✅ done, needs your attention" ;;
  waiting) title="$agent — needs input";  body="⏸ waiting for input/approval" ;;
  *)       exit 0 ;;
esac

# Resolve the pane tty: 1) tmux (exact, even for background hooks), 2) process-tree walk.
tty=""
if [ -n "$TMUX_PANE" ]; then
  tty="$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)"
fi
if [ -z "$tty" ]; then
  pid=$$
  while [ "$pid" != "1" ] && [ -n "$pid" ]; do
    t="$(ps -o tty= -p "$pid" 2>/dev/null | tr -d ' ')"
    case "$t" in "" | "??") pid="$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')" ; continue ;; esac
    [ -e "/dev/$t" ] && tty="/dev/$t" && break
    pid="$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')"
  done
fi
[ -n "$tty" ] && [ -e "$tty" ] || exit 0

sub="$(tmux display-message -p '#{window_name}' 2>/dev/null)"
printf '\033Ptmux;\033\033]777;notify;%s (%s);%s\007\033\\' \
  "$title" "${sub:-tmux}" "$body" > "$tty"
