function fish_title
    if test $PWD = ~
        echo '~'
    else
        echo (basename $PWD)
    end
end
