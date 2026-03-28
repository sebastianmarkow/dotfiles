function fzf_cd --description "Interactive cd"
    if not type fzf >/dev/null 2>&1
        echo 'cdf: error fzf not installed'
        exit 1
    end

    fd --type d --exclude .git --exclude node_modules --exclude .cache --exclude __pycache__ --exclude .venv | fzf --header="Change directory" --tiebreak=end,length | read -l fzf_last_select
    if [ $fzf_last_select ]
        cd $fzf_last_select
    end
end
