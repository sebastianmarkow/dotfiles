function git-home
    set -l giturl (git config --get remote.origin.url)
    set giturl (string replace -r 'git@' '//' $giturl)
    set giturl (string replace -r '\.git$' '' $giturl)
    set giturl (string replace 'https:' '' $giturl)
    set giturl (string replace -a ':' '/' $giturl)
    if test -n "$giturl"
        set giturl "http:$giturl"
        echo $giturl
        command open $giturl
    else
        echo error
    end
end
