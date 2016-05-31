function screencast --description "Take screenshots every x seconds"
    switch (count $argv)
        case 2
            if not test -d $argv[1]
                echo "screencast: error\"" $argv[1] "\" not a directory"
                exit 1
            end
            if not test $argv[2] -gt 0
                echo -s "screencast: error \"" $argv[2] "\" is not greater than zero or not a number"
                exit 1
            end
            while true
                set -l screen_date (date +%s)
                screencapture -t jpg -C -m -x $argv[1]/$screen_date.jpg
                sleep $argv[2]
            end
        case '*'
            echo 'screencast: error too many parameters'
            exit 1
    end
end
