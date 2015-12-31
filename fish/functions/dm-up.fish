function dm-up --description 'Bring up docker-machine'
    switch (count $argv)
        case 0
            docker-machine start default
            eval (docker-machine env default)
        case 1
            docker-machine start $argv
            eval (docker-machine env $argv)
        case '*'
            printf "dm-up: error too many arguments"
    end
end

function __dm-up_completion -d 'Docker-machine completion'
    docker-machine ls -q --filter driver=virtualbox
end
