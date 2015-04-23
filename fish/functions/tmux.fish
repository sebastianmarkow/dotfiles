function tmux
    command tmux attach-session -t $USER > /dev/null 2>&1; or command tmux -2 new-session -s $USER
end
