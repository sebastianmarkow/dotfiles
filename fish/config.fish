# No, no, no!
status --is-interactive
or exit 0
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
set -x PAGER 'less'
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
set -x FZF_DEFAULT_COMMAND 'ag -g "" --nocolor --nogroup'
set -x XZ_OPT '-T0'

# Hook
test -d $XDG_DATA_HOME/fish/generated_completions
or fish_update_completions
command -s jump >/dev/null
and . (jump shell fish | psub)

# Abbreviations
abbr rp 'repo'
abbr mv 'mv -i'
abbr cp 'cp -i'
abbr vim 'nvim'
abbr v 'nvim'
abbr g 'git'
abbr dm 'docker-machine'
abbr d 'docker'
abbr t 'tmux'

# Alias
alias ldd 'otool -L'
alias tig 'nvim +GV +bd1'
alias near 'grep -C 10'
alias lower 'tr A-Z a-z'
alias upper 'tr a-z A-Z'
alias map 'xargs -n1'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'

# Fish
set fish_color_command yellow
set fish_color_param cyan
set fish_color_quote brred
set fish_color_error red
set fish_color_autosuggestion brblue

set __sk_cmd_timing_limit 3

set __sk_right_prompt_status_fg white
set __sk_right_prompt_status_bg red
set __sk_right_prompt_timing_fg white
set __sk_right_prompt_timing_bg magenta

set __sk_prompt_pwd_fg brblue
set __sk_prompt_pwd_bg 95a5a6
set __sk_prompt_root_fg brblue
set __sk_prompt_root_bg yellow

set __sk_mode_string_normal '|'
set __sk_mode_string_insert '>'
set __sk_mode_string_replace '_'
set __sk_mode_string_visual '/'
set __sk_mode_color_normal blue
set __sk_mode_color_insert green
set __sk_mode_color_replace red
set __sk_mode_color_visual magenta

set __sk_git_status_staged_sign '+'
set __sk_git_status_unstaged_sign '-'
set __sk_git_status_unmerged_sign '?'
set __sk_git_status_untracked_sign '…'
set __sk_git_status_default_color (set_color normal)
set __sk_git_status_staged_color (set_color green)
set __sk_git_status_unstaged_color (set_color red)
set __sk_git_status_unmerged_color (set_color brred)
set __sk_git_status_untracked_color (set_color blue)

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1

# Vi mode
fish_vi_key_bindings
