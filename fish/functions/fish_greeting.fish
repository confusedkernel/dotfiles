function fish_greeting
    # Setting the randomizer and logging the information
    set -l lyrics (cat ~/.config/.lyrics/*/* | shuf -n 1)
    set -l filename (grep -l "$lyrics" ~/.config/.lyrics/*/* | sed 's/.*\///' | sed 's/\.txt$//')
    set -l subfolder_name (basename (dirname (grep -l "$lyrics" ~/.config/.lyrics/*/*)))
    
    # Coloring the text based on eras
    if test "$subfolder_name" = "Midnights"
        set_color --bold --italic 5a6b99 
    else if test "$subfolder_name" = "folklore"
        set_color --bold --italic a39586
    else if test "$subfolder_name" = "evermore"
        set_color --bold --italic a16b20 
    else if test "$subfolder_name" = "Lover"
        set_color --bold --italic c495c1 
    else if test "$subfolder_name" = "reputation"
        set_color --bold --italic 878787
    else if test "$subfolder_name" = "1989"
        set_color --bold --italic 87a6bb 
    else if test "$subfolder_name" = "Red"
        set_color --bold --italic b84b3e
    else if test "$subfolder_name" = "Speak Now"
        set_color --bold --italic aa97bd
    else if test "$subfolder_name" = "Fearless"
        set_color --bold --italic c49b04 
    else if test "$subfolder_name" = "Taylor Swift"
        set_color --bold --italic 72ab6f 
    else if test "$subfolder_name" = "Droplets"
        set_color --bold --italic 
    else
        set_color normal
    end
    
    # Print the lyrics onto terminal
    echo -n '"' && echo -n $lyrics && echo -n '" - ' && echo -n $filename && echo ', Taylor Swift'
    
    set_color normal
end


