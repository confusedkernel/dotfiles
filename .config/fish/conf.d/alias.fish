# General aliases
alias ls='lsd --tree --depth 1'
alias la='lsd -a --tree --depth 1'
alias pip='pip3'
alias cf='clear && fish_greeting'
alias fc ='set_fzf_colors'

# For fzf because the binding doesn't work
alias log='_fzf_search_git_log'
alias sts='_fzf_search_git_status'
alias dir='_fzf_search_directory'
alias hst='_fzf_search_history'
alias bh='_fzf_search_branch'
alias chk='_fzf_search_checkout'

# Abbr for easy access
abbr gc 'git commit'
abbr gp 'git push'
abbr ga 'git add .'
abbr gb 'git blame'
abbr gr 'git reset --hard'

# For opening apps
alias nv='nvim'
alias code='codium'
