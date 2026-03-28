function fzf_file_edit --description 'Select files and open in editor'
    if not command -s fzf >/dev/null
        echo 'error: fzf not found'
        return 1
    end
    set -l selected (fzf --header="Edit files" --preview="bat --color=always --style=numbers {}" -m -q (commandline -t) --print0 | string split0)
    if set -q selected[1]
        $EDITOR -o $selected
    end
end
