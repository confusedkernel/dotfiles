# Dotfiles

Personal dotfiles managed with [`yadm`](https://yadm.io/).

## What's here

- Shell config (`.zshrc`, `.bashrc`)
- Editor config (`.config/nvim`, `.vimrc`)
- Terminal tools (`.tmux.conf`, `.config/kitty`, `starship`)
- Git and global ignores (`.gitconfig`, `.gitignore_global`)

## Migration

```bash
# 1) Install yadm
brew install yadm

# 2) Clone this dotfiles repo
yadm clone <repo-url>

# 3) Apply local overrides (if any)
yadm bootstrap
```
