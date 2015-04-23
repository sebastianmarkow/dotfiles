function repo
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
            echo 'too many parameters'
    end
end
