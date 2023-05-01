# General aliases
alias ls='tree -Cph -L 1'
alias la='tree -Cpha -L 1'
alias pip='pip3'
alias cf='clear && fish_greeting'
alias fc ='set_fzf_colors'

# For fzf because the binding doesn't work
alias log='_fzf_search_git_log'
alias sts='_fzf_search_git_status'
alias dir='_fzf_search_directory'
alias hst='_fzf_search_history'

# Abbr for easy access
abbr gc 'git commit'
abbr gp 'git push'
abbr ga 'git add .'
abbr gb 'git blame'

# For opening apps
alias nv='nvim'
alias code='codium'
