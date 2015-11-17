# No, no, no!
status --is-interactive; or exit 0
set -e fish_greeting

# Path
set -x DEVPATH $HOME/Developer
set -x GOPATH $DEVPATH/go
set -x GOBIN $GOPATH/bin
set -x NQDIR $HOME/.cache/nq/
set -x PATH /usr/local/sbin $GOBIN $PATH

# Default
set -x EDITOR vim
set -x VISUAL $EDITOR
set -x PAGER less
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '3;33'
set -x LSCOLORS 'gxfxdxcxbxexexhbhdacad'
set -x LS_COLORS 'di=36:ln=35:so=33:pi=32:ex=31:bd=34:cd=34:su=37;41:sg=37;43:tw=00;42:ow=00;43:'
set -x LANG en_US.UTF-8
set -x LC_CTYPE 'en_US.UTF-8'
set -x LC_MESSAGES 'en_US.UTF-8'
set -x LC_COLLATE C

# Env
set -x HOMEBREW_NO_EMOJI 1
set -x FZF_DEFAULT_OPTS '--color=16,header:11 --inline-info'
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
set -x YANKCM 'pbcopy make'

# Hook
[ -d $HOME/.local/share/fish/generated_completions ]; or fish_update_completions
[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# Abbreviations
abbr nq 'nq -q'
abbr rp 'repo'
abbr mv 'mv -i'
abbr cp 'cp -i'

# Alias
alias near 'grep -C 10'
alias lower 'tr A-Z a-z'
alias upper 'tr a-z A-Z'

# Fish
set fish_color_command yellow
set fish_color_param cyan
set fish_color_quote 'd26936'
set fish_color_error red

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1

set __fish_prompt_sign_root '#'
set __fish_prompt_sign_default '$'
set __fish_prompt_sign_error '!'

set __fish_mode_string_normal 'normal'
set __fish_mode_string_insert 'insert'
set __fish_mode_string_replace 'replace'
set __fish_mode_string_visual 'visual'
set __fish_mode_color_normal blue
set __fish_mode_color_insert green
set __fish_mode_color_replaced red
set __fish_mode_color_visual magenta

# Vi mode
fish_vi_mode
