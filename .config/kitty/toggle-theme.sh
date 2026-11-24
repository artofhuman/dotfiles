#!/bin/sh
# Toggle kitty light/dark theme. nvim/emacs/tmux follow via DEC mode 2031.
cd "$(dirname "$0")" || exit 1
if [ "$(readlink theme.conf)" = alabaster_dark.conf ]; then
  ln -sfn alabaster_light_bg.conf theme.conf
else
  ln -sfn alabaster_dark.conf theme.conf
fi
kitten @ load-config
