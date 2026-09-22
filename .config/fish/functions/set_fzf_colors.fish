function set_fzf_colors --description 'Match fzf and bat colors to the current macOS appearance'
    # macOS only. `defaults` stores the appearance and doubles as the platform
    # check, so this avoids shelling out to `uname` as well.
    command -q defaults
    or return

    # `defaults read` costs a few milliseconds where the equivalent osascript
    # call costs well over a hundred.
    # The key is absent in light mode, so the result must be quoted.
    set -l appearance (defaults read -g AppleInterfaceStyle 2>/dev/null)
    set -l mode light
    if test "$appearance" = Dark
        set mode dark
    end

    set -l shared '--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"'

    if test $mode = dark
        set -gx FZF_DEFAULT_OPTS "$shared
            --color=fg:#d0d0d0,hl:#81a2be
            --color=fg+:#d0d0d0,bg+:#3c3c3c,hl+:#81a2be
            --color=info:#b294bb,prompt:#b294bb,pointer:#81a2be
            --color=marker:#b294bb,spinner:#b294bb,header:#b294bb"
        set -gx fzf_preview_file_cmd "bat --style=numbers --color=always --theme OneHalfDark"
    else
        set -gx FZF_DEFAULT_OPTS "$shared
            --color=fg:#4d4d4c,hl:#e68a99
            --color=fg+:#4d4d4c,bg+:#eeeeee,hl+:#e68a99
            --color=info:#52799e,prompt:#a87dd4,pointer:#e68a99
            --color=marker:#52799e,spinner:#52799e,header:#52799e"
        set -gx fzf_preview_file_cmd "bat --style=numbers --color=always --theme OneHalfLight"
    end
end
