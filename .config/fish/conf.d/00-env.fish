# Environment every shell needs, interactive or not, so scripts and editors
# inherit the same settings.

set -gx EDITOR nvim
set -gx LC_ALL en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8

# fish_add_path is idempotent, so re-running it on each start is harmless.
fish_add_path -g $HOME/.antigravity/antigravity/bin # Antigravity
fish_add_path -g $HOME/.opencode/bin # opencode
fish_add_path -g $HOME/.local/bin
