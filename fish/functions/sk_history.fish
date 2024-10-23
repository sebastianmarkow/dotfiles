function sk_history --description 'Filter history interactively'
    if not command -s sk >/dev/null
        echo 'error: sk not found'
        exit 1
    end
    history -z | sk --read0 --tac --no-sort --tiebreak=index --header="Select history" -q (commandline -b) | read -z last_select
    if [ $last_select ]
        commandline -rb $last_select
    end
    commandline -f repaint
end
