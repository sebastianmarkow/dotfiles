function push --description "Send push notification via Pushover"
    if not set -q PUSHOVER_TOKEN; or not set -q PUSHOVER_GROUP; or not test (count $argv) -eq 1; or test -z $argv[1]
        return 1
    end

    set -l host (hostname -s)

    curl -s \
        -F "token=$PUSHOVER_TOKEN" \
        -F "user=$PUSHOVER_GROUP" \
        -F "title=from $host" \
        -F "message=$argv[1]" \
        https://api.pushover.net/1/messages.json > /dev/null 2>&1
end
