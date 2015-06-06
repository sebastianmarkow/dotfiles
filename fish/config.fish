set -x PATH /usr/local/bin /usr/local/sbin $PATH


set -x EDITOR vim
set -x VISUAL $EDITOR
set -x PAGER less
set -x LESS "--ignore-case --chop-long-lines --long-prompt --silent"

# go
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -x PATH $GOBIN $PATH
set -x PATH /usr/local/Cellar/go/1.4.2/libexec/bin $PATH
set -x HOMEBREW_NO_EMOJI 1

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

# Status Chars
set __fish_git_prompt_char_dirtystate 'd'
set __fish_git_prompt_char_stagedstate 's'
set __fish_git_prompt_char_untrackedfiles 'u'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


set -x LANG=en_US.UTF-8

# node
set -x PATH (brew --prefix node)/bin $PATH

# python
# set -x PIP_REQUIRE_VIRTUALENV true
set -x VIRTUALFISH_COMPAT_ALIASES true
eval (python3.4 -m virtualfish)

set -e fish_greeting

if not test -d ~/.config/fish/generated_completions
    fish_update_completions
end

