function tmux --description 'Attach to tmux session'
    switch (count $argv)
        case 0
            command tmux attach-session -t $USER > /dev/null 2>&1; or command tmux new-session -s $USER
        case '*'
            command tmux $argv
    end
end
