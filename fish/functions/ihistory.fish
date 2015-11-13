function ihistory --description "Interactive history"
    if not type "fzf" > /dev/null 2>&1
        echo "ihistory: error fzf not installed"
        return 1
    end
    history | fzf --tiebreak=index --header="history" -q (commandline -b) | read -l fzf_last_select
    if [ $fzf_last_select ]
        commandline -rb $fzf_last_select
    else
        commandline -i ""
    end
end
