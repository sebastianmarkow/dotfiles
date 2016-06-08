function __sk_git_status --description "Display git status"
    if not command -s git >/dev/null
        return 1
    end

    set -l repo_info (command git rev-parse --git-dir --abbrev-ref HEAD ^/dev/null)
    test -n "$repo_info"
    or return

    set -l git_dir $repo_info[1]
    set -l branch $repo_info[2]
    set -l files_status (command git status --porcelain ^/dev/null | cut -c 1-2 | sort)

    set staged 0
    set unstaged 0
    set untracked 0
    set unmerged 0

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
        set operation "$operation|"
    end

    set -l neutral "$__sk_git_status_default_color"

    for t in staged unstaged untracked unmerged
        if test "$$t" != "0"
            set -l color __sk_git_status_"$t"_color
            set -l sign __sk_git_status_"$t"_sign
            set $t "$$color$$sign$$t$neutral"
        else
            set -e "$t"
        end
    end

    set file_desc "$staged$unstaged$unmerged$untracked"

    if test -n "$file_desc"
        set file_desc "$file_desc|"
    end

    echo -n "$neutral$file_desc$operation$branch"
    set_color normal
end