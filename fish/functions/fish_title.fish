function fish_title
    echo ' '
    if test $PWD = ~
        echo '~'
    else
        echo (basename $PWD)
    end
end
