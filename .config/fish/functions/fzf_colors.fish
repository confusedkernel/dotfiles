function set_fzf_colors
    if test (uname) = "Darwin"
        set mode (osascript -e 'tell application "System Events" to return dark mode of appearance preferences' 2>/dev/null)
        if test "$mode" = "true"
            # Dark mode color scheme
            set -gx FZF_DEFAULT_OPTS '
                --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"
                --color=fg:#d0d0d0,hl:#81a2be
                --color=fg+:#d0d0d0,bg+:#3c3c3c,hl+:#81a2be
                --color=info:#b294bb,prompt:#b294bb,pointer:#81a2be
                --color=marker:#b294bb,spinner:#b294bb,header:#b294bb'
        else
            # Light mode color scheme
            set -gx FZF_DEFAULT_OPTS '
                --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker=">"
                --color=fg:#4d4d4c,hl:#e68a99
                --color=fg+:#4d4d4c,bg+:#eeeeee,hl+:#e68a99
                --color=info:#52799e,prompt:#a87dd4,pointer:#e68a99
                --color=marker:#52799e,spinner:#52799e,header:#52799e'
        end
    end
end

