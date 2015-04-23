function __repo_completion -d "bla"
    ghq list --unique
end


complete -xc repo -f -A -a "(__repo_completion)"
