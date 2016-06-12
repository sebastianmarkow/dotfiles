function historyf --description 'Filter history interactively'
    if not command -s fzf >/dev/null
        echo 'historyf: fzf not found'
        exit 1
    end
    history | fzf --tiebreak=index --header="history" -q (commandline -b) | read -l fzf_last_select
    if [ $fzf_last_select ]
        commandline -rb $fzf_last_select
    end
    commandline -f repaint
end
