function sk_file_edit --description 'Select files and open in editor'
    if not type sk >/dev/null 2>&1
        echo 'error: sk not found'
        exit 1
    end
    sk --print0 --header="Edit files" --preview="head -$LINES {}" -m -q (commandline -t) | read -z last_select
    if [ $last_select ]
        string split '\n' $last_select | string join ' ' | xargs nvim -o
    end
end
