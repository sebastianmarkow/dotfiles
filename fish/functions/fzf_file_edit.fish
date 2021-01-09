function fzf_file_edit --description 'Select files and open in editor'
    if not type 'fzf' >/dev/null 2>&1
        echo 'error: fzf not found'
        exit 1
    end
    fzf --header="Edit files" --preview="head -$LINES {}" -m -q (commandline -t) | read -z -l fzf_last_select
    if [ $fzf_last_select ]
        string split '\n' $fzf_last_select | string join ' ' | xargs nvim -o
    end
end
