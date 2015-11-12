function __rp_completion -d "rp path completion"
    if not type "ghq" > /dev/null 2>&1
        return
    end
    ghq list --unique
end

complete -xc rp -a "(__rp_completion)"
complete -xc rp -s d -a "(__rp_completion)"
