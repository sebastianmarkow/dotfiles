function sk_filepath --description 'Select/insert filepath into commandline'
    if not type sk >/dev/null 2>&1
        echo 'error: sk not found'
        exit 1
    end
    sk --print0 --header="Insert filepath" --preview="ccat --color=always {}" -m -q (commandline -t) | read -z last_select
    if [ $last_select ]
        commandline -i (string split '\n' $last_select | string join ' ')
    end
    commandline -f repaint
end
