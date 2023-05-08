function _fzf_search_checkout
    set fzf_git_log_format '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'
    git log --no-show-signature --color=always --format=format:$fzf_git_log_format --date=short --all | fzf --ansi --preview 'git show --color=always {1}' --preview-window=right:60% | awk '{print $1}' | xargs git checkout
end

