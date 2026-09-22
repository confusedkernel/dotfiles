status is-interactive
or exit

# Each of these shells out to a tool that prints the same init script every
# time, so the output is cached and re-sourced instead of regenerated. The cache
# refreshes itself when the tool is upgraded; `fish_cache_clear` forces it.
__init_cache starship starship init fish --print-full-init
__init_cache zoxide zoxide init fish --hook=prompt
__init_cache thefuck thefuck --alias

# LS_COLORS is a value rather than fish code, and it is derived from the theme
# file, so that file is watched for changes too.
__init_cache --var LS_COLORS --watch $__fish_config_dir/ls_theme.yml \
    vivid vivid -m 24-bit generate $__fish_config_dir/ls_theme.yml

set_fzf_colors
