status is-interactive; or exit

function __dotfiles_staleness_check --on-event fish_prompt
    functions -e __dotfiles_staleness_check

    # Resolve dotfiles root via symlink (fast, no subprocess)
    # ~/.config/fish -> .../dotfiles/fish, strip the trailing /fish component
    if not set -q __dotfiles_path; or not test -d "$__dotfiles_path/.git"
        set -l link (readlink $__fish_config_dir)
        if test -n "$link"
            set -U __dotfiles_path (string replace -r '/fish/?$' '' $link)
        else if command -q ghq
            set -U __dotfiles_path (ghq list --full-path sebastianmarkow/dotfiles 2>/dev/null)[1]
        end
    end

    set -l repo $__dotfiles_path
    test -d "$repo/.git" || return

    # Background git fetch — throttled to once per hour
    set -l ts_file $HOME/.cache/fish/dotfiles_fetch_ts
    set -l now (date +%s)
    set -l age 99999

    if test -f $ts_file
        set age (math $now - (cat $ts_file))
    end

    # Check every 12h
    if test $age -gt 43200
        mkdir -p $HOME/.cache/fish
        echo $now >$ts_file
        git -C $repo fetch --quiet 2>/dev/null &
        disown
    end

    # Local staleness check — compares HEAD vs cached remote tracking branch (no network)
    set -l behind (git -C $repo rev-list HEAD..@{upstream} --count 2>/dev/null)
    test -n "$behind" -a "$behind" != "0" || return

    set_color yellow
    printf "dotfiles: %s commit(s) behind remote\n" $behind
    set_color normal
end
