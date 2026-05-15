function fish_greeting
    # Choose one lyric line from the JSON-based lyric store using jq
    set -l json_file ~/.config/.lyrics/album-song-lyrics.json

    if not test -f "$json_file"
        return
    end

    set -l selection (jq -r '
        [.[] | select(.Songs != null) | .Title as $album | .Code as $code | .Songs[] | select(.Lyrics != null) | .Title as $song | .Lyrics[] | select(.Text != null) | "\($album)\t\($code)\t\($song)\t\(.Text)"] | .[(now * 1000 | floor) % length]
    ' "$json_file")

    if test -z "$selection"
        return
    end

    set -l fields (string split (printf "\t") -- "$selection")
    set -l album_title $fields[1]
    set -l album_code $fields[2]
    set -l song_title $fields[3]
    set -l lyric_text $fields[4]

    set -l album_key (string lower "$album_title")
    set -l album_code_key (string lower "$album_code")

    set -l lyric_color

    switch "$album_code_key"
        case tpd
            set lyric_color B3997F
        case lsg
            set lyric_color E0903E
    end

    if not set -q lyric_color[1]
        switch "$album_key"
            case "the tortured poets department"
                set lyric_color B3997F
            case "the life of a showgirl"
                set lyric_color E0903E
            case midnights
                set lyric_color 5A67D8
            case folklore
                set lyric_color 7F7A6E
            case evermore
                set lyric_color C58B75
            case lover
                set lyric_color D18ED7
            case reputation
                set lyric_color 8A8A8A
            case 1989
                set lyric_color 7FBCD2
            case red
                set lyric_color C35763
            case "speak now"
                set lyric_color B585C1
            case fearless
                set lyric_color D3B868
            case "taylor swift"
                set lyric_color A6C29F
        end
    end

    if set -q lyric_color[1]
        set_color --bold --italic $lyric_color
    else
        set_color --bold --italic
    end

    # Print the lyric line
    echo -n '"' && echo -n "$lyric_text" && echo -n '" - ' && echo -n "$song_title" && echo ', Taylor Swift'

    set_color normal
end
