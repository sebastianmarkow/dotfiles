function insert_filepath --description 'Select/insert filepath into commandline'
    if not type 'fzf' >/dev/null 2>&1
        echo 'error: fzf not found'
        exit 1
    end
    fzf --header="insert filepath" --preview="head {}" --preview-window=up:30% -m -q (commandline -t) | read -z -l fzf_last_select
    if [ $fzf_last_select ]
        commandline -i (string split '\n' $fzf_last_select | string join ' ')
    end
    commandline -f repaint
end
