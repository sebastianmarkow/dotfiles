function ihistory --description "Interactive history"
    if not type "fzf" > /dev/null 2>&1
        echo "ihistory: error fzf not installed"
        return
    end
    history | fzf --tiebreak=index | read fzf_last_select
    if [ $fzf_last_select ]
        commandline $fzf_last_select
    else
        commandline ''
    end
end
