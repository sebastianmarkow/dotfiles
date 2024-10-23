function sk_cd --description "Interactive cd"
    if not type sk >/dev/null 2>&1
        echo 'cdf: error sk not installed'
        exit 1
    end

    find * -type d | sk --print0 --header="Change directory" --tiebreak=end,length | read -z last_select
    if [ $last_select ]
        cd $last_select
    end
end
