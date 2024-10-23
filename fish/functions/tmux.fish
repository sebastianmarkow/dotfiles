function tmux --description 'Attach to tmux session'
    switch (count $argv)
        case 0
            set -l sessions (command tmux ls -F "#S [#{session_windows} windows] #{?session_attached,(#{session_attached} attached),}" 2> /dev/null | string split "\n")
            switch (count $sessions)
                case 0
                    command tmux new-session -A -s $USER
                    return 0
                case 1
                    if [ ! $TMUX ]
                        command tmux new-session -A -s (echo $sessions | cut -f 1 -d " ")
                    end
                    return 0
                case '*'
                    echo -e (string join "\n" $sessions) | sk --print0 --tac --no-sort --header="Choose tmux session" | read -z last_select
                    if [ $last_select ]
                        set -l session (echo $last_select | cut -f 1 -d " ")
                        if [ $TMUX ]
                            tmux switch-client -t $session
                        else
                            tmux new-session -A -s $session
                        end
                    end
                    return 0
            end
        case '*'
            command tmux $argv
            return 0
    end
end
