function __repo_completion -d "bla"
    ghq list --unique
end

complete -xc repo -a "(__repo_completion)"
complete -xc repo -s d -a "(__repo_completion)"
