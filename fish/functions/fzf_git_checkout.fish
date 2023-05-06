function fzf_git_checkout
    git log --pretty=format:'%h %s' | fzf --ansi --preview 'git show --color=always {1}' --preview-window=right:60% | awk '{print $1}' | xargs git checkout
end

