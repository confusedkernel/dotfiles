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

    # Coloring the text based on eras
    if test "$album_code_key" = tpd -o "$album_key" = "the tortured poets department"
        set_color --bold --italic B3997F
    else if test "$album_code_key" = lsg -o "$album_key" = "the life of a showgirl"
        set_color --bold --italic E0903E
    else if test "$album_key" = midnights
        set_color --bold --italic 5A67D8
    else if test "$album_key" = folklore
        set_color --bold --italic 7F7A6E
    else if test "$album_key" = evermore
        set_color --bold --italic C58B75
    else if test "$album_key" = lover
        set_color --bold --italic D18ED7
    else if test "$album_key" = reputation
        set_color --bold --italic 8A8A8A
    else if test "$album_key" = 1989
        set_color --bold --italic 7FBCD2
    else if test "$album_key" = red
        set_color --bold --italic C35763
    else if test "$album_key" = "speak now"
        set_color --bold --italic B585C1
    else if test "$album_key" = fearless
        set_color --bold --italic D3B868
    else if test "$album_key" = "taylor swift"
        set_color --bold --italic A6C29F
    else
        set_color --bold --italic
    end

    # Print the lyric line
    echo -n '"' && echo -n "$lyric_text" && echo -n '" - ' && echo -n "$song_title" && echo ', Taylor Swift'

    set_color normal
end
