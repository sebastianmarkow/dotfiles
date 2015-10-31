# Path
set -x PATH /usr/local/bin /usr/local/sbin $PATH

set -x TERM xterm-256color
set -x LSCOLORS "gxfxdxcxbxexexhbhdacad";
set -x LS_COLORS "di=36:ln=35:so=33:pi=32:ex=31:bd=34:cd=34:su=37;41:sg=37;43:tw=00;42:ow=00;43:"

set -x LANG en_US.UTF-8
set -x LC_CTYPE "en_US.UTF-8"
set -x LC_MESSAGES "en_US.UTF-8"
set -x LC_COLLATE C

# Editor
set -x EDITOR vim
set -x VISUAL $EDITOR
set -x PAGER less
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '3;33'

# Golang
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -x PATH /usr/local/Cellar/go/1.4.2/libexec/bin $GOBIN $PATH

# No greeting, thanks
set -e fish_greeting

# Homebrew
set -x HOMEBREW_NO_EMOJI 1

# Hooks
[ -d $HOME/.local/share/fish/generated_completions ]; or fish_update_completions
[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# NQ
set -x NQDIR $HOME/.cache/nq/
alias nq "nq -q"

# Node
set -x PATH (brew --prefix node)/bin $PATH

# Python
eval (python2 -m virtualfish compat_aliases)

# Git prompt
set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1

# Color
set fish_color_command yellow
set fish_color_param cyan
set fish_color_quote 'd26936'
set fish_color_error red

# Prompt
set __fish_user_prompt_string_root '#'
set __fish_user_prompt_color_root red
set __fish_user_prompt_string_default '$'
set __fish_user_prompt_color_default normal

# Prompt (vi)
set __fish_vi_prompt_string_normal 'normal'
set __fish_vi_prompt_string_insert 'insert'
set __fish_vi_prompt_string_visual 'visual'
set __fish_vi_prompt_color_normal red
set __fish_vi_prompt_color_insert cyan
set __fish_vi_prompt_color_visual yellow

# Start in vi mode
fish_vi_mode
