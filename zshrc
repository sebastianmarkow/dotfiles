# Path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Term
export TERM="xterm-256color"

# editing
export PAGER="less"
export LESS="--ignore-case --raw-control-chars --chop-long-lines --LONG-PROMPT --SILENT"
export EDITOR="vim"
export VISUAL=$EDITOR
export USE_EDITOR=$EDITOR

# History
export HISTFILE=~/.tmp/zsh/zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Vars
export LOGNAME=$(id -un)
export UNAME=$(uname)

# Report CPU time
export REPORTTIME=10

# Modules
autoload -Uz compinit && compinit -d ~/.tmp/zsh/zcompdump
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz zcalc

zmodload zsh/complist
zmodload zsh/mathfunc
zmodload zsh/datetime

# General
setopt no_beep              # no bells
setopt correct              # correct command typos
setopt multios              # descriptors as pipes
setopt prompt_subst         # allow functions in prompt
setopt zle
setopt vi

# Glob
setopt glob_complete
setopt glob_dots
setopt extended_glob
setopt no_case_glob
setopt numeric_glob_sort
setopt no_glob_dots

# Changing directories
setopt auto_cd              # automatically cd into directories
setopt auto_pushd
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt pushd_ignore_dups

# Safety
setopt rm_star_wait

# History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

# Background
setopt long_list_jobs
setopt notify
unsetopt bg_nice

# Completion
setopt menu_complete
setopt complete_in_word
setopt always_to_end
setopt auto_list
setopt auto_param_slash
setopt mark_dirs
setopt hash_list_all
unsetopt flowcontrol

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.tmp/zsh/cache/$HOST
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt 'At %p: Hit TAB for more'
zstyle ':completion:*' select-prompt 'Scrolling active: current selection at %p'
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Colors
if [[ $UNAME == Linux ]]; then
  export LS_COLORS="di=32;40:ln=35;40:so=36;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
fi

if [[ $UNAME == Darwin ]]; then
  export CLICOLOR=1
  export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"
  export HOMEBREW_NO_EMOJI=1
fi

export LS_OPTIONS="--color=auto"

# Version control
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%u%c %b'
zstyle ':vcs_info:*' actionformats '%u%c %a|%b'
zstyle ':vcs_info:*' branchformat '%b'
zstyle ':vcs_info:*' stagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'

# Prompt
[[ $SSH_CONNECTION != '' ]] && prompt_user='%n@%m '

if [[ $LOGNAME == 'root' ]]; then
  prompt_symbol='# '
else
  prompt_symbol='$ '
fi

PROMPT='$prompt_user%F{red}${PWD/#$HOME/~}%f $prompt_symbol'
RPROMPT='$(vcs_info && echo $vcs_info_msg_0_)'
SPROMPT='Correct %F{red}%R%f to %F{green}%r%f? (Yes, No, Abort, Edit) '

# Keys
bindkey "^r" history-incremental-search-backward

# Aliases
alias ls="ls -GFh"
alias la="ls -GFha"
alias ll="ls -GFhl"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias vi="vim"
alias tmux="tmux attach-session -t $LOGNAME > /dev/null 2>&1  || tmux -2 new-session -s $LOGNAME"

# Functions
function extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)  tar -jxvf $1                        ;;
      *.tar.gz)   tar -zxvf $1                        ;;
      *.tar.xz)   tar -xvfJ $1                        ;;
      *.bz2)      bunzip2 $1                          ;;
      *.gz)       gunzip $1                           ;;
      *.tar)      tar -xvf $1                         ;;
      *.tbz2)     tar -jxvf $1                        ;;
      *.tgz)      tar -zxvf $1                        ;;
      *.zip)      unzip $1                            ;;
      *.ZIP)      unzip $1                            ;;
      *)          echo "'$1' unknown file compression";;
    esac
  else
    echo "'$1' not a file"
  fi
}

# .zlocal
[[ -e ~/.zlocal ]] && source ~/.zlocal

# .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
