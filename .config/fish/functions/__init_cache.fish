function __init_cache --description 'Source a tool init script from disk cache, regenerating only when it goes stale'
    argparse --stop-nonopt 'var=' 'watch=+' -- $argv
    or return

    set -l name $argv[1]
    set -l tool $argv[2]

    # Not installed: stay quiet, exactly like the `command -q` guards this replaced.
    set -l bin (command --search $tool)
    or return

    set -l cache $__fish_cache_dir/init/$name.fish

    # Stale when the cache is missing, older than the tool itself, or older than
    # any file the output was generated from.
    set -l stale
    if not test -f $cache
        set stale yes
    else if test $bin -nt $cache
        set stale yes
    else
        for input in $_flag_watch
            if test -e $input -a $input -nt $cache
                set stale yes
                break
            end
        end
    end

    if set -q stale[1]
        set -l output ($argv[2..])
        or return # generator failed; keep any previous cache rather than writing a broken one

        mkdir -p (path dirname $cache)
        if set -q _flag_var
            # Not fish code, just a value: store it as an assignment.
            echo "set -gx $_flag_var "(string escape -- (string join \n $output)) >$cache.tmp
        else
            printf '%s\n' $output >$cache.tmp
        end
        mv -f $cache.tmp $cache
    end

    source $cache
end
