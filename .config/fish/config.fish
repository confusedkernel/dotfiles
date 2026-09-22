# Configuration is split across conf.d/, which fish sources before this file.
# Only things that must run last belong here.

# iTerm2 shell integration, loaded after the prompt is set up.
status is-interactive
and test -e $HOME/.iterm2_shell_integration.fish
and source $HOME/.iterm2_shell_integration.fish
