# General aliases
alias ls='lsd --tree --depth 1'
alias la='lsd -a --tree --depth 1'
alias pip='pip3'
alias cf='clear && fish_greeting'
alias fc='set_fzf_colors'
alias py='python3'

# Useful brew alias
alias brewdeps="brew leaves | xargs brew deps --include-build --tree"

# Tmux
alias t='tmux'
alias tk='tmux kill session'

# For yadm
alias dotfile='yadm'
abbr da 'dotfile add -u :/'
abbr dc 'dotfile commit'
abbr dp 'dotfile push'
abbr dr 'dotfile reset --hard'
abbr ds 'dotfile status -u ./'
abbr db 'dotfile blame'
abbr dpl 'dotfile pull'

# For fzf because the binding doesn't work
alias gsl='_fzf_search_git_log'
alias gss='_fzf_search_git_status'
alias gsk='_fzf_search_checkout'
alias gsb='_fzf_search_branch'
alias dir='_fzf_search_directory'
alias hst='_fzf_search_history'

# Abbr for easy access
abbr gc 'git commit'
abbr gp 'git push'
abbr ga 'git add .'
abbr gb 'git blame'
abbr gr 'git reset --hard'
abbr gpl 'git pull'
abbr lg lazygit

# For opening apps
alias nv='nvim .'
alias code='open -b com.microsoft.VSCode'

# For Criterion compiling and other brew stuff
alias meep='-I /usr/local/include -L /usr/local/lib'
