function fzf_filepath --description 'Select/insert filepath into commandline'
    if not command -s fzf >/dev/null
        echo 'error: fzf not found'
        return 1
    end
    fzf --header="Insert filepath" --preview="bat --color=always {}" -m -q (commandline -t) | read -z -l fzf_last_select
    if [ $fzf_last_select ]
        commandline -i (string split '\n' $fzf_last_select | string join ' ')
    end
    commandline -f repaint
end
