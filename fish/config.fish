if status is-interactive
	# Editor to nvim
	set -gx EDITOR nvim

	# Commands to run in interactive sessions can go here
	set -x LC_ALL en_US.UTF-8
	set -x LC_CTYPE en_US.UTF-8

	set -gx fzf_preview_file_cmd "bat --style=numbers --color=always --theme OneHalfLight"
	set -gx LS_COLORS (vivid -m 24-bit generate ~/.config/fish/ls_theme.yml)

	set -gx GPG_TTY (tty)

	# Source starship
	starship init fish | source

	#Zoxide
	zoxide init fish --hook="prompt" | source

end

# iTerm2
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish


