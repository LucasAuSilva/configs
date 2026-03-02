#!/usr/bin/env fish

function try
    set -l script ~/.local/try.rb
    set -l tries_dir ~/src/tries

    if not test -f $script
        echo "try: script not found: $script" >&2
        return 1
    end

    # Run in exec mode so it emits shell script
    set -l out (ruby $script exec --path $tries_dir $argv 2>/dev/tty | string collect)
    set -l status_code $pipestatus[1]

    if test $status_code -eq 0
        eval $out
    else
        echo $out
        return $status_code
    end
end
