function __fzf_cmd
    if not type "fzf" > /dev/null 2>&1
        echo "__fzf_cmd: error fzf not installed"
        return 1
    end
    fzf -m --header="file" -q (commandline -t) | string join " " | read -l fzf_last_select
    if [ $fzf_last_select ]
        commandline -rt "$fzf_last_select "
    else
        commandline -i ""
    end
end
