function cdf --description "Interactive cd"
    if not type 'fzf' >/dev/null 2>&1
        echo 'cdf: error fzf not installed'
        exit 1
    end

    find * -type d | fzf --header="Change directory" --tiebreak=end,length | read -l fzf_last_select
    if [ $fzf_last_select ]
        cd $fzf_last_select
    end
end
