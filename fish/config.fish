# No, no, no!
status --is-interactive; or exit 1

# Fish features
set -Ua fish_features qmark-noglob

# Path
set -x PATH $PATH /usr/local/sbin
set -x GOPATH $HOME/Developer/go
set -x GOBIN $GOPATH/bin
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache
test -d $GOBIN; and set -x PATH $GOBIN $PATH

# Base
set -x EDITOR 'nvim'
set -x VISUAL $EDITOR
set -x PAGER 'less -R'
set -x MANPAGER 'less -X'
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x GREP_OPTIONS '--color=auto'
set -x LSCOLORS 'ExGxBxDxCxEgEdxbxgxcxd'
set -x LANG 'en_US.UTF-8'
set -x LC_CTYPE 'en_US.UTF-8'
set -x LC_MESSAGES 'en_US.UTF-8'
set -x LC_COLLATE 'C'

# Env
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_EMOJI 1
set -x HOMEBREW_NO_ENV_HINTS 1
set -x FZF_DEFAULT_OPTS '--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up'
set -x FZF_DEFAULT_COMMAND 'rg --files --color never'
set -x XZ_OPT '-T0'

# Hooks
command -s jump > /dev/null; and source (jump shell fish | psub)
command -s pyenv > /dev/null; and source (pyenv init --path | psub)
test -d $XDG_DATA_HOME/fish/generated_completions; or fish_update_completions
test -f "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"; and source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

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
alias ldd 'otool -L'
alias lower 'tr A-Z a-z'
alias map 'xargs -n1'
alias near 'rg -C 10'
alias repo 'fzf_repo'
alias tig 'nvim +GV +bd1'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'
alias upper 'tr a-z A-Z'
alias yt2audio 'youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'

alias ktc 'kubectl top pods -A | sort --reverse --key 3 --numeric | head -25'
alias ktm 'kubectl top pods -A | sort --reverse --key 4 --numeric | head -25'

# Fish
set fish_greeting ''

set fish_color_comment blue
set fish_color_command brmagenta
set fish_color_param white
set fish_color_quote brred
set fish_color_error red
set fish_color_redirection yellow
set fish_color_operator brred
set fish_color_autosuggestion brgreen
set fish_color_selection --background=blue
set fish_color_end brred

set fish_color_prompt_git_fg white
set fish_color_prompt_git_bg brred
set fish_color_prompt_status_fg white
set fish_color_prompt_status_bg red
set fish_color_prompt_timing_fg white
set fish_color_prompt_timing_bg magenta

set fish_color_prompt_pwd_fg blue
set fish_color_prompt_pwd_bg brblack
set fish_color_prompt_root_fg brblue
set fish_color_prompt_root_bg red
set fish_color_prompt_venv_fg white
set fish_color_prompt_venv_bg magenta

set fish_color_mode_string_normal 'NORMAL'
set fish_color_mode_string_insert 'INSERT'
set fish_color_mode_string_replace 'REPLACE'
set fish_color_mode_string_visual 'VISUAL'
set fish_color_mode_color_normal blue
set fish_color_mode_color_insert green
set fish_color_mode_color_replace red
set fish_color_mode_color_visual magenta

set cmd_timing_limit 5

# Vi mode
set fish_key_bindings 'fish_vi_key_bindings'

# Custom bindings
fish_user_key_bindings

set -g fisher_path $XDG_DATA_HOME/fisher_plugins

set -p fish_function_path fish_function_path[1] $fisher_path/functions
set -p fish_complete_path fish_complete_path[1] $fisher_path/completions

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2>/dev/null
end

set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
