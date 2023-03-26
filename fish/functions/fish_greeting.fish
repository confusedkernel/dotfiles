function fish_greeting
    set_color --bold --italics
    set -l lyrics (cat ~/.config/.lyrics/*/* | shuf -n 1)
    set -l filename (grep -l "$lyrics" ~/.config/.lyrics/*/* | sed 's/.*\///' | sed 's/\.txt$//')
    echo -n '"' && echo -n $lyrics && echo -n '" - ' && echo -n $filename && echo ', Taylor Swift'
end



