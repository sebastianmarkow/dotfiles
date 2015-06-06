function tmux --description 'Invoke tmux session'
    switch (count $argv)
        case 0
            command tmux attach-session -t $USER > /dev/null 2>&1; or command tmux -2 new-session -s $USER
        case '*'
            command tmux $argv
    end
end
