if status is-interactive
	# Editor to nvim
	set -gx EDITOR nvim

	# Commands to run in interactive sessions can go here
	set -x LC_ALL en_US.UTF-8
	set -x LC_CTYPE en_US.UTF-8

	# Source starship
	starship init fish | source

	#Zoxide
	zoxide init fish --hook="prompt" | source

end

# iTerm2
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish


