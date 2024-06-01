function fish_greeting
    # Setting the randomizer and logging the information
    set -l lyrics (cat ~/.config/.lyrics/*/* | shuf -n 1)
    set -l filename (grep -l "$lyrics" ~/.config/.lyrics/*/* | sed 's/.*\///' | sed 's/\.txt$//')
    set -l subfolder_name (basename (dirname (grep -l "$lyrics" ~/.config/.lyrics/*/*)))
    
    # Coloring the text based on eras
    if test "$subfolder_name" = "Midnights"
        set_color --bold --italic 3F5FB5 #3F5FB5
    else if test "$subfolder_name" = "folklore"
        set_color --bold --italic 66685B #66685B
    else if test "$subfolder_name" = "evermore"
        set_color --bold --italic D89079 #D89079
    else if test "$subfolder_name" = "Lover"
        set_color --bold --italic E092E0 #E092E0
    else if test "$subfolder_name" = "reputation"
        set_color --bold --italic 878787 #878787
    else if test "$subfolder_name" = "1989"
        set_color --bold --italic 93CCDC #93CCDC
    else if test "$subfolder_name" = "Red"
        set_color --bold --italic A54E56 #A54E56
    else if test "$subfolder_name" = "Speak Now"
        set_color --bold --italic C895BF #C895BF
    else if test "$subfolder_name" = "Fearless"
        set_color --bold --italic D9B263 #D9B263
    else if test "$subfolder_name" = "Taylor Swift"
        set_color --bold --italic A3BE8C #A3BE8C
    else if test "$subfolder_name" = "TTPD"
        set color --bold --italic A59E91 #A59E91
    else if test "$subfolder_name" = "Droplets"
        set_color --bold --italic 
    else
        set_color normal
    end
    
    # Print the lyrics onto terminal
    echo -n '"' && echo -n $lyrics && echo -n '" - ' && echo -n $filename && echo ', Taylor Swift'
    
    set_color normal
end


