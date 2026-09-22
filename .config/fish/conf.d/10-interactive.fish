status is-interactive
or exit

fish_vi_key_bindings

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -gx GPG_TTY (tty)
