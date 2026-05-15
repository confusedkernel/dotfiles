if status is-interactive
	fish_vi_key_bindings

	# Editor to nvim
	set -gx EDITOR nvim

	# Commands to run in interactive sessions can go here
	set -x LC_ALL en_US.UTF-8
	set -x LC_CTYPE en_US.UTF-8
	set -gx GPG_TTY (tty)

	# FZF color schemes
	set_fzf_colors

    # Set VI cursor style
    set -gx fish_cursor_default block
    set -gx fish_cursor_insert line
    set -gx fish_cursor_replace_one underscore
    set -gx fish_cursor_visual block

	if command -q vivid
		set -gx LS_COLORS (vivid -m 24-bit generate "$HOME/.config/fish/ls_theme.yml")
	end

    # Source the fuck
    if command -q thefuck
        thefuck --alias | source
    end

	# Source starship
	if command -q starship
		starship init fish | source
	end

	# Set max open files because my neovim is broken somehow
    # ulimit -n 10924

	# Zoxide
	if command -q zoxide
		zoxide init fish --hook="prompt" | source
	end

end

# iTerm2
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish



# Added by Antigravity
fish_add_path -g "$HOME/.antigravity/antigravity/bin"

# opencode
fish_add_path -g "$HOME/.opencode/bin"
fish_add_path -g "$HOME/.local/bin"
