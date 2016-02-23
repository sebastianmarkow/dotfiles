function tmux --description 'Attach to tmux session'
    set -e TMPDIR
    switch (count $argv)
        case 0
            command tmux new-session -A -s $USER
        case '*'
            command tmux $argv
    end
end
