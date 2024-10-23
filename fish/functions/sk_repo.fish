function sk_repo --description 'Go to repository'
    if not type ghq >/dev/null 2>&1
        echo 'repo: error ghq not installed'
        exit 1
    else if not type sk >/dev/null 2>&1
        echo 'repo: error sk not installed'
        exit 1
    end
    switch (count $argv)
        case 0
            ghq list | sk --print0 --header="Go to repository" --exact --tiebreak=end,length | read -z last_select
            if [ $last_select ]
                cd (ghq list -e -p $last_select)
            end
        case 1
            cd (ghq list -e -p $argv[1])
        case 2
            switch $argv[1]
                case del
                    ghq list -p -e $argv[2] | xargs rm -rf
                case get
                    ghq get $argv[2]
                case '*'
                    echo 'repo: error unknown command'
            end
        case '*'
            echo 'repo: error too many parameters'
    end
end

function __repo_completion -d 'Repository completion'
    if type ghq >/dev/null 2>&1
        ghq list --unique
    end
end
