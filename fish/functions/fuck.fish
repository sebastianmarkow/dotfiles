function fuck --on-event fish_command_not_found
    env THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $history[1] ^ /dev/null | read -l fuck
    [ -z $fuck ]; and return
    commandline -r $fuck
end
