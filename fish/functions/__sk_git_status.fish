function __sk_git_status --description "Display git status"
    if not command -s git >/dev/null
        return 1
    end

    set -l repo_info (command git rev-parse --git-dir --abbrev-ref HEAD ^/dev/null)
    test -n "$repo_info"
    or return 0

    set -l git_dir $repo_info[1]
    set -l branch $repo_info[2]
    set -l files_status (command git status --porcelain ^/dev/null | cut -c 1-2 | sort)

    set -l sign_staged '→'
    set -l sign_unstaged '↯'
    set -l sign_unmerged '⇄'
    set -l sign_untracked '…'
    set -l sign_stashed '↩'
    set -l sign_ahead '↑'
    set -l sign_behind '↓'

    set -l staged 0
    set -l unstaged 0
    set -l untracked 0
    set -l unmerged 0
    set -l stashed 0

    if test -r $git_dir/refs/stash
        set stashed (count (command git stash list ^ /dev/null))
    end

    for f in $files_status
        switch $f
            case '\?\?'
                set untracked (math "$untracked" + 1)
            case 'U*' '*U' 'DD' 'AA'
                set unmerged (math "$unmerged" + 1)
            case '? '
                set staged (math "$staged" + 1)
            case ' ?'
                set unstaged (math "$unstaged" + 1)
            case '??'
                set staged (math "$staged" + 1)
                set unstaged (math "$unstaged" + 1)
        end
    end

    echo (command git rev-list --count --left-right '@{upstream}'...HEAD ^/dev/null) | read -l behind ahead

    for t in staged unstaged untracked unmerged stashed ahead behind
        if test "$$t" != "" -a "$$t" != "0"
            set -l sign sign_"$t"
            set $t "$$sign$$t"
        else
            set -e "$t"
        end
    end

    set -l files "$staged$unstaged$unmerged$untracked$stashed"

    if test -n "$files"
        set files "$files | "
    end

    set -l upstream "$ahead$behind"

    if test -n "$upstream"
        set upstream "$upstream | "
    end

    set -l operation

    if test -d $git_dir/rebase-merge -o -d $git_dir/rebase-apply
        set operation "rebase"
    else if test -f $git_dir/MERGE_HEAD
        set operation "merge"
    else if test -f $git_dir/CHERRY_PICK_HEAD
        set operation "cherry-pick"
    else if test -f $git_dir/REVERT_HEAD
        set operation "revert"
    else if test -f $git_dir/BISECT_LOG
        set operation "bisect"
    end

    if test -n "$operation"
        set operation "$operation | "
    end

    echo -n "$files$upstream$operation$branch"
end
