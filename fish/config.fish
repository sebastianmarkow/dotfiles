# No, no, no!
status --is-interactive
or exit 1
set -e fish_greeting

# Path
set -x PATH $PATH /usr/local/sbin
set -x GOPATH $HOME/Developer/go
set -x GOBIN $GOPATH/bin
set -x CARGO_HOME $HOME/Developer/cargo
set -x CARGO_BIN $CARGO_HOME/bin
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

if test -d $GOBIN
    set -x PATH $PATH $GOBIN
end
if test -d $CARGO_BIN
    set -x PATH $PATH $CARGO_BIN
end

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
set -x FZF_DEFAULT_OPTS '--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up'
set -x FZF_DEFAULT_COMMAND 'rg -g "" -l --color never ""'
set -x XZ_OPT '-T0'

# xHyve
set -x XHYVE_CPU_COUNT 2
set -x XHYVE_MEMORY_SIZE 4096
set -x XHYVE_DISK_SIZE 20000
set -x XHYVE_EXPERIMENTAL_NFS_SHARE true

# Hooks
test -d $XDG_DATA_HOME/fish/generated_completions; or fish_update_completions
command -s jump >/dev/null; and . (jump shell fish | psub)


# Abbreviations
abbr cp 'cp -iR'
abbr d 'docker'
abbr dm 'docker-machine'
abbr g 'git'
abbr mv 'mv -i'
abbr nb 'jupyter notebook'
abbr rp 'repo'
abbr t 'tmux'
abbr v 'nvim'
abbr vim 'nvim'
abbr yt 'youtube-dl'

# Alias
alias ag 'rg'
alias compare 'diff -rq'
alias ldd 'otool -L'
alias lower 'tr A-Z a-z'
alias gitroot 'cd (git rev-parse --show-cdup)'
alias map 'xargs -n1'
alias near 'grep -C 10'
alias tig 'nvim +GV +bd1'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'
alias upper 'tr a-z A-Z'
alias lower 'tr A-Z a-z'
alias yt2audio 'youtube-dl --extract-audio --audio-format mp3 --audio-quality 0'
alias vf 'eval (python3 -m virtualfish compat_aliases)'

# Fish
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

set __sk_cmd_timing_limit 5

set __sk_right_prompt_git_fg white
set __sk_right_prompt_git_bg brred
set __sk_right_prompt_status_fg white
set __sk_right_prompt_status_bg red
set __sk_right_prompt_timing_fg white
set __sk_right_prompt_timing_bg magenta

set __sk_prompt_pwd_fg brblue
set __sk_prompt_pwd_bg 95a5a6
set __sk_prompt_root_fg brblue
set __sk_prompt_root_bg red
set __sk_prompt_venv_fg white
set __sk_prompt_venv_bg magenta

set __sk_mode_string_normal 'NORMAL'
set __sk_mode_string_insert 'INSERT'
set __sk_mode_string_replace 'REPLACE'
set __sk_mode_string_visual 'VISUAL'
set __sk_mode_color_normal blue
set __sk_mode_color_insert green
set __sk_mode_color_replace red
set __sk_mode_color_visual magenta


# User bindings
fish_user_key_bindings

# Vi mode
fish_vi_key_bindings
