function __sk_status_code --description "Display status code"
    set -l last_status $argv[1]
    switch $last_status
        case 0
        case '*'
            echo -s -n "$__sk_status_code_color $last_status "
            set_color normal
    end
end
