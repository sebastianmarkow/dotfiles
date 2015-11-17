function repo --description 'Go to repository'
    if not type 'ghq' > /dev/null 2>&1
        echo 'repo: error ghq not installed'
        return 1
    else if not type 'fzf' > /dev/null 2>&1
        echo 'repo: error fzf not installed'
        return 1
    end
    switch (count $argv)
        case 0
            ghq list | fzf --header="repository" | read -l fzf_last_select
            if [ $fzf_last_select ]
                cd (ghq list -e -p $fzf_last_select)
            end
        case 1
            cd (ghq list -p $argv[1])
        case 2
            if test $argv[1] = '-d'
                ghq list -p -e $argv[2] | xargs rm -rf
            end
        case '*'
            echo 'repo: error too many parameters'
    end
end

function __repo_completion -d 'Repository completion'
    if not type 'ghq' > /dev/null 2>&1
        return
    end
    ghq list --unique
end
