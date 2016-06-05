# No, no, no!
status --is-interactive
or exit 0
set -e fish_greeting

# Path
set -x GOPATH $HOME/Developer/go
set -x GOBIN $GOPATH/bin
set -x PATH $PATH /usr/local/sbin $GOBIN
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

# Default
set -x EDITOR 'nvim'
set -x VISUAL $EDITOR
set -x PAGER 'less'
set -x MANPAGER 'less -X'
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x GREP_OPTIONS '--color=auto'
set -x LSCOLORS 'gxfxdxcxbxexexhbhdacad'
set -x LS_COLORS 'di=36:ln=35:so=33:pi=32:ex=31:bd=34:cd=34:su=37;41:sg=37;43:tw=00;42:ow=00;43:'
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

# Alias
alias dm 'docker-machine'
alias d 'docker'
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

set __sk_status_code_color (set_color -b red)(set_color black)

set __sk_cmd_timing_limit 3
set __sk_cmd_timing_color (set_color -b brmagenta)(set_color black)

set __sk_prompt_sign_root '#'
set __sk_prompt_sign_default '$'

set __sk_mode_string_normal '|'
set __sk_mode_string_insert '>'
set __sk_mode_string_replace '_'
set __sk_mode_string_visual '-'
set __sk_mode_color_normal brmagenta
set __sk_mode_color_insert green
set __sk_mode_color_replace red
set __sk_mode_color_visual yellow

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
