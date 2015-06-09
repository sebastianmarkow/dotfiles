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
[ -d /Users/sebastian/.local/share/fish/generated_completions ]; or fish_update_completions
[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# node
set -x PATH (brew --prefix node)/bin $PATH

# python
set -x VIRTUALFISH_COMPAT_ALIASES true
eval (python3.4 -m virtualfish)

# Colors
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch magenta
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_char_dirtystate 'd'
set __fish_git_prompt_char_stagedstate 's'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

# Start in vi mode
fish_vi_mode
