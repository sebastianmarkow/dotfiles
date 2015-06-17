function rp --description 'Go to repositories'
    if not type "ghq" > /dev/null 2>&1
        echo 'rp: error ghq not installed'
        return
    end
    switch (count $argv)
        case 0
            cd (ghq root)
        case 1
            cd (ghq list -p -e $argv[1])
        case 2
            echo $argv[1]
            if test $argv[1] = '-d'
                ghq list -p -e $argv[2] | xargs rm -rf
            end
        case '*'
            echo 'rp: error too many parameters'
    end
end
