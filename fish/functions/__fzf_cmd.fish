function __fzf_cmd
    if not type "fzf" > /dev/null 2>&1
        echo "__fzf_cmd: error fzf not installed"
        return 1
    end
    fzf | read fzf_last_select
    if [ $fzf_last_select ]
        commandline -i $fzf_last_select
    end
end
