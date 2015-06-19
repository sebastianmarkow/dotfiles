function fish_user_cm --description 'Display ps1'
    switch $USER
        case root
            echo '#'
        case '*'
            echo '$'
    end
end
