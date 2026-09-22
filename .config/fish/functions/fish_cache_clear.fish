function fish_cache_clear --description 'Drop cached tool init scripts so they regenerate on the next shell start'
    set -l dir $__fish_cache_dir/init
    if test -d $dir
        rm -f $dir/*.fish
        echo "Cleared cached init scripts in $dir"
    else
        echo "Nothing cached in $dir"
    end
end
