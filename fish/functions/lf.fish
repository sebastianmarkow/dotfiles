function lf --description 'lf wrapper which will cd into last directory'
    set lftmp (mktemp)
    command lf -last-dir-path=$lftmp $argv
    if test -f "$lftmp"
        set dir (cat $lftmp)
        rm -f $lftmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end
