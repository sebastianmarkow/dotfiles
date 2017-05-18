function fish_title
    switch $PWD
        case $HOME
            echo '~'
        case '*'
            echo (basename $PWD)
    end
end
