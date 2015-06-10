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
set -x VIRTUALFISH_COMPAT_ALIASES true
eval (python3 -m virtualfish)

# Colors
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set blue (set_color blue)
set gray (set_color -o black)

# Git prompt
set __fish_git_prompt_show_informative_status = true
set __fish_git_prompt_showdirtystate = true
set __fish_git_prompt_showuntrackedfiles = true
set __fish_git_prompt_showcolorhints = true

# Vi prompt
set __fish_vi_prompt_string_normal 'normal'
set __fish_vi_prompt_string_insert 'insert'
set __fish_vi_prompt_string_visual 'visual'
set __fish_vi_prompt_color_normal red
set __fish_vi_prompt_color_insert yellow
set __fish_vi_prompt_color_visual blue

# Start in vi mode
fish_vi_mode
