#!/usr/bin/env fish

function try
    set script ~/.local/try.rb
    set tries_dir ~/src/tries

    if not test -x $script
        echo "try: script not found or not executable: $script" >&2
        return 1
    end

    # Run try.rb and capture output
    set cmd (ruby $script cd --path $tries_dir $argv 2>/dev/tty)
    set status_code $status

    if test $status_code -ne 0
        echo $cmd
        return $status_code
    end

    # If the command contains shell operators, eval it
    if string match -q "* && *" -- $cmd
        eval $cmd
    else
        echo $cmd
    end
end

