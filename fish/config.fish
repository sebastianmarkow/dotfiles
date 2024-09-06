# No, no, no!
status is-interactive; or exit 1

# Path
set -x GOPATH $HOME/Developer/go
set -x GOBIN $GOPATH/bin
set -x PATH /usr/local/bin /usr/local/sbin $HOME/Applications/bin $PATH $HOME/.krew/bin $HOME/.config/hack/bin
set -x PATH $GOBIN $PATH
set -x PYENV_ROOT $HOME/.pyenv
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

# Base
set -x EDITOR 'nvim'
set -x VISUAL $EDITOR
set -x PAGER 'less -R'
set -x MANPAGER 'less -X'
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x GREP_OPTIONS '--color=auto'
set -x LANG 'en_US.UTF-8'
set -x LC_CTYPE 'en_US.UTF-8'
set -x LC_MESSAGES 'en_US.UTF-8'
set -x LC_COLLATE 'C'

# Env
set -x FZF_DEFAULT_OPTS '
    --color=fg:#908caa,bg:#232136,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
    --inline-info
    --tiebreak=end,length
    --bind=shift-tab:toggle-down,tab:toggle-up'
set -x FZF_DEFAULT_COMMAND 'rg --files --color never'
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_EMOJI 1
set -x HOMEBREW_NO_ENV_HINTS 1
set -x STARSHIP_CONFIG $HOME/.starship.toml
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x XZ_OPT '-T0'

# Hooks
command -s starship > /dev/null; and starship init fish | source; and enable_transience
command -s zoxide > /dev/null; and zoxide init --cmd j --hook pwd fish | source
command -s uv > /dev/null; and uv generate-shell-completion fish | source
test -d $XDG_DATA_HOME/fish/generated_completions; or fish_update_completions
test -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"; and source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

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
abbr --add pp 'pbpaste'
abbr --add rp 'repo'
abbr --add sl 'ls'
abbr --add tf 'terraform'
abbr --add tg 'terragrunt'
abbr --add up 'upgrade'
abbr --add v 'nvim'
abbr --add vim 'nvim'
abbr --add yt 'youtube-dl'

# Aliases
alias ag 'rg'
alias compare 'diff -rq'
alias gitroot 'test -n (git rev-parse --show-cdup); and cd (git rev-parse --show-cdup)'
alias ktc 'kubectl top pods -A | sort --reverse --key 3 --numeric | head -25'
alias ktm 'kubectl top pods -A | sort --reverse --key 4 --numeric | head -25'
alias ldd 'otool -L'
alias lower 'tr A-Z a-z'
alias map 'xargs -n1'
alias near 'rg -C 10'
alias repo 'fzf_repo'
alias ssh 'TERM=xterm-color command ssh'
alias tig 'nvim +GV +bd1'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'
alias upper 'tr a-z A-Z'
alias yt2m4a 'yt-dlp --extract-audio --audio-format m4a --audio-quality 0'
alias yt2mp3 'yt-dlp --extract-audio --audio-format mp3 --audio-quality 0'

# Fisher
set -g fisher_path $XDG_DATA_HOME/fisher_plugins
set -p fish_function_path fish_function_path[1] $fisher_path/functions
set -p fish_complete_path fish_complete_path[1] $fisher_path/completions
for file in $fisher_path/conf.d/*.fish
    builtin source $file 2>/dev/null
end

# Google Cloud
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# Fish
set fish_greeting ''
set -Ua fish_features qmark-noglob
fish_config theme choose "Rosé Pine Moon"
fish_add_path "/Users/sklatt/.local/share/../bin"
fish_user_key_bindings
