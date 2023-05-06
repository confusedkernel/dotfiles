function _fzf_search_branch
    git rev-parse HEAD > /dev/null 2>&1; and git branch --color=always --all --sort=-committerdate \
        | grep -v HEAD \
        | fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" (echo {} | sed "s/.* //")' \
        | sed "s/.* //" \
        || return
end

