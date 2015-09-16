# Global path
set -x PATH /usr/local/bin /usr/local/sbin $PATH

set -x TERM xterm-256color
set -xU LS_COLORS "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34:su=0:sg=0:tw=0:ow=0:"

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

# node
set -x PATH (brew --prefix node)/bin $PATH

# python
eval (python3 -m virtualfish compat_aliases)

# Git prompt
set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showuntrackedfiles 1
set __fish_git_prompt_showcolorhints 1

# User prompt
set __fish_user_prompt_string_root '#'
set __fish_user_prompt_color_root red
set __fish_user_prompt_string_default '$'
set __fish_user_prompt_color_default normal

# Vi prompt
set __fish_vi_prompt_string_normal 'normal'
set __fish_vi_prompt_string_insert 'insert'
set __fish_vi_prompt_string_visual 'visual'
set __fish_vi_prompt_color_normal magenta
set __fish_vi_prompt_color_insert blue
set __fish_vi_prompt_color_visual cyan

# Start in vi mode
fish_vi_mode
