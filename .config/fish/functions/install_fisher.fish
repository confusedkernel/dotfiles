function install_fisher --description 'Install fisher and the plugins listed in fish_plugins'
    # git.io shut down in 2022; fetch the installer from the repo directly.
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
    and fisher update
end
