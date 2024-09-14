function git-home
    set -l giturl (git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
    if test -n "$giturl"
        set giturl "http:$giturl"
        echo $giturl
        command open $giturl
    else
        echo error
    end
end
