# No, no, no!
status is-interactive; or exit 1

set fish_greeting ''

# Path
set -gx GOPATH $HOME/Developer/go
set -gx GOBIN $GOPATH/bin
set -gx PYENV_ROOT $HOME/.pyenv
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin $HOME/.local/bin $GOBIN $PATH

# Base
set -gx EDITOR 'nvim'
set -gx VISUAL $EDITOR
set -gx MANPAGER 'less -X'
set -gx LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -gx LANG 'en_US.UTF-8'
set -gx LC_CTYPE 'en_US.UTF-8'
set -gx LC_MESSAGES 'en_US.UTF-8'
set -gx LC_COLLATE 'C'

# Env
set -gx FZF_DEFAULT_OPTS '
  --color=fg:#908caa,bg:-1,hl:#ea9a97
  --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
  --color=border:#6e6a86,header:#3e8fb0,gutter:#232136
  --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
  --tiebreak=end,length
  --border="none"
  --marker=""
  --prompt="  "
  --bind=shift-tab:toggle-down,tab:toggle-up'
set -gx FZF_DEFAULT_COMMAND 'rg --files --color never'
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_EMOJI 1
set -gx HOMEBREW_NO_ENV_HINTS 1
set -gx STARSHIP_CONFIG $HOME/.starship.toml
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
set -gx XZ_OPT '-T0'
set -gx TG_TF_FORWARD_STDOUT true
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
set -gx POETRY_VIRTUALENVS_IN_PROJECT true

# Kitty
if set -q KITTY_INSTALLATION_DIR
    set -g KITTY_SHELL_INTEGRATION enabled
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

# Pyenv
if command -q pyenv
    # Remove any existing shim entries before prepending to avoid duplicates in nested shells
    while set pyenv_index (contains -i -- "$PYENV_ROOT/shims" $PATH)
        set -eg PATH[$pyenv_index]
    end
    set -e pyenv_index
    set -gx PATH "$PYENV_ROOT/shims" $PATH
    set -gx PYENV_SHELL fish

    # Cache brew --prefix once (it's slow)
    if not set -q __PYENV_PREFIX
        set -gx __PYENV_PREFIX (brew --prefix pyenv)
    end

    # Rehash shims after pip/poetry installs
    function __pyenv_rehash_on_use --on-event fish_preexec
        if string match -q "*pip*install*" $argv[1]; or string match -q "*pip*uninstall*" $argv[1]; or string match -q "*poetry*add*" $argv[1]; or string match -q "*poetry*remove*" $argv[1]
            command pyenv rehash 2>/dev/null
        end
    end

    function pyenv
        set command $argv[1]
        set -e argv[1]
        switch "$command"
        case rehash shell
            source (pyenv "sh-$command" $argv|psub)
        case "*"
            command pyenv "$command" $argv
        end
    end
end

# Opencode
fish_add_path $HOME/.opencode/bin

# Abbreviations
abbr --add cp 'cp -iR'
abbr --add d 'docker'
abbr --add g 'git'
abbr --add gcp 'gcloud'
abbr --add gr 'gitroot'
abbr --add k 'kubectl'
abbr --add kctx 'kubectx'
abbr --add kns 'kubens'
abbr --add la 'ls -a'
abbr --add mv 'mv -i'
abbr --add ngit 'neogit'
abbr --add oc 'opencode'
abbr --add pp 'pbpaste'
abbr --add rp 'repo'
abbr --add sl 'ls'
abbr --add tf 'terraform'
abbr --add tg 'terragrunt'
abbr --add up 'upgrade'
abbr --add v 'nvim'
abbr --add vim 'nvim'
abbr --add yt 'yt-dlp'
abbr --add gcm --set-cursor=% 'git commit -m "%"'
abbr --add gfix --set-cursor=% 'git commit --fixup=%'
abbr --add gri --set-cursor=% 'git rebase -i HEAD~%'

# Aliases
alias ag 'rg'
alias compare 'diff -rq'
alias grep 'grep --color=auto'
alias gitroot 'cd (git rev-parse --show-toplevel)'
alias h 'fzf_history'
alias ktc 'kubectl top pods -A | sort --reverse --key 3 --numeric | head -25'
alias ktm 'kubectl top pods -A | sort --reverse --key 4 --numeric | head -25'
alias ldd 'otool -L'
alias lower 'tr A-Z a-z'
alias map 'xargs -n1'
alias near 'rg -C 10'
alias neogit 'nvim +Neogit +bd1'
alias repo 'fzf_repo'
alias ssh 'TERM=xterm-color command ssh'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'
alias upper 'tr a-z A-Z'
alias y 'yazi'
alias yt2m4a 'yt-dlp --extract-audio --audio-format m4a --audio-quality 0'
alias yt2mp3 'yt-dlp --extract-audio --audio-format mp3 --audio-quality 0'

# Fish
# vi bindings first, then user overrides on top
fish_vi_key_bindings
fish_user_key_bindings

# Defer theme + tool init to first prompt
function __init_interactive --on-event fish_prompt
    functions -e __init_interactive

    # Theme
    set -g __FISH_THEME_LOADED 1
    fish_config theme choose "Rose Pine Moon"

    mkdir -p $HOME/.cache/fish

    # Source tool init from cache, regenerating if the binary is newer than the cache
    function __cached_source
        set -l bin (command -s $argv[1])
        test -n "$bin"; or return
        set -l cache $HOME/.cache/fish/$argv[1].fish
        if not test -f $cache; or test $bin -nt $cache
            $argv[2..-1] > $cache
        end
        source $cache
    end

    if command -q starship
        __cached_source starship starship init fish
        enable_transience
    end

    __cached_source bob bob complete fish
    __cached_source zoxide zoxide init --cmd j --hook pwd fish
    __cached_source direnv direnv hook fish
    __cached_source atuin atuin init fish --disable-up-arrow
    __cached_source navi navi widget fish

    if set -q __PYENV_PREFIX
        source $__PYENV_PREFIX/completions/pyenv.fish
    end

    functions -e __cached_source
end
