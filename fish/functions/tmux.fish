function tmux --description 'Attach to tmux session'
    set -e TMPDIR
    switch (count $argv)
        case 0
            command tmux -u new-session -A -s $USER
        case '*'
            command tmux -u $argv
    end
end
