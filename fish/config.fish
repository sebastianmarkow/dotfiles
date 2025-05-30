# No, no, no!
status is-interactive; or exit 1

set -U fish_features qmark-noglob
set fish_greeting ''

# Path
set -x GOPATH $HOME/Developer/go
set -x GOBIN $GOPATH/bin
set -x PYENV_ROOT $HOME/.pyenv
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $GOBIN $PATH

# Base
set -x EDITOR 'nvim'
set -x VISUAL $EDITOR
set -x PAGER 'less -R'
set -x MANPAGER 'less -X'
set -x LESS '--ignore-case --chop-long-lines --long-prompt --silent'
set -x LANG 'en_US.UTF-8'
set -x LC_CTYPE 'en_US.UTF-8'
set -x LC_MESSAGES 'en_US.UTF-8'
set -x LC_COLLATE 'C'

# Env
set -x FZF_DEFAULT_OPTS '
  --color=fg:#908caa,bg:-1,hl:#ea9a97
  --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
  --color=border:#6e6a86,header:#3e8fb0,gutter:#232136
  --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
  --tiebreak=end,length
  --border="none"
  --marker=""
  --prompt="  "
  --bind=shift-tab:toggle-down,tab:toggle-up'
set -x FZF_DEFAULT_COMMAND 'rg --files --color never'
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_EMOJI 1
set -x HOMEBREW_NO_ENV_HINTS 1
set -x STARSHIP_CONFIG $HOME/.starship.toml
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x XZ_OPT '-T0'
set -x TERRAGRUNT_FORWARD_TF_STDOUT 1
set -x USE_GKE_GCLOUD_AUTH_PLUGIN True

# Python
set -x POETRY_VIRTUALENVS_IN_PROJECT true

# Hooks
if status is-interactive
  # Async hooks for better startup time
  function __setup_tools --on-event fish_prompt
    # Only run this once
    functions -e __setup_tools

    # Starship
    command -s starship > /dev/null; and begin
      starship init fish | source
      enable_transience
    end

    # Zoxide
    command -s zoxide > /dev/null; and zoxide init --cmd j --hook pwd fish | source
  end
end

# Abbreviations
abbr --add cp 'cp -iR'
abbr --add d 'docker'
abbr --add g 'git'
abbr --add gcp 'gcloud'
abbr --add gr 'gitroot'
abbr --add k 'kubectl'
abbr --add kctx 'kubectx'
abbr --add kns 'kubens'
abbr --add la 'ls -a'
abbr --add mv 'mv -i'
abbr --add ngit 'neogit'
abbr --add pp 'pbpaste'
abbr --add rp 'repo'
abbr --add sl 'ls'
abbr --add tf 'terraform'
abbr --add tg 'terragrunt'
abbr --add up 'upgrade'
abbr --add v 'nvim'
abbr --add vim 'nvim'
abbr --add yt 'yt-dlp'

# Aliases
alias ag 'rg'
alias compare 'diff -rq'
alias grep 'grep --color=auto'
alias gitroot 'test -n (git rev-parse --show-cdup); and cd (git rev-parse --show-cdup)'
alias h 'fzf_history'
alias ktc 'kubectl top pods -A | sort --reverse --key 3 --numeric | head -25'
alias ktm 'kubectl top pods -A | sort --reverse --key 4 --numeric | head -25'
alias ldd 'otool -L'
alias lower 'tr A-Z a-z'
alias map 'xargs -n1'
alias near 'rg -C 10'
alias neogit 'nvim +Neogit +bd1'
alias repo 'fzf_repo'
alias ssh 'TERM=xterm-color command ssh'
alias tree 'command tree -C --dirsfirst | less -FRX'
alias treed 'command tree -C -d | less -FRX'
alias upper 'tr a-z A-Z'
alias y 'yazi'
alias yt2m4a 'yt-dlp --extract-audio --audio-format m4a --audio-quality 0'
alias yt2mp3 'yt-dlp --extract-audio --audio-format mp3 --audio-quality 0'

# Kitty
if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION enabled
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end

# Pyenv
while set pyenv_index (contains -i -- "/Users/sklatt/.pyenv/shims" $PATH)
set -eg PATH[$pyenv_index]; end; set -e pyenv_index
set -gx PATH '/Users/sklatt/.pyenv/shims' $PATH
set -gx PYENV_SHELL fish

# Cache pyenv prefix (brew --prefix is slow)
if not set -q __PYENV_PREFIX
  set -gx __PYENV_PREFIX (brew --prefix pyenv)
end
source $__PYENV_PREFIX'/completions/pyenv.fish'

# Lazy rehash
function __pyenv_rehash_on_use --on-event fish_preexec
  if string match -q "*pip*install*" $argv[1]; or string match -q "*pip*uninstall*" $argv[1]; or string match -q "*poetry*add*" $argv[1]; or string match -q "*poetry*remove*" $argv[1]
    command pyenv rehash 2>/dev/null
  end
end

function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case "*"
    command pyenv "$command" $argv
  end
end

# Fish
# Load key bindings only once at startup
fish_user_key_bindings
fish_vi_key_bindings

# Defer theme application to first prompt if not already set
if status is-interactive; and not set -q __FISH_THEME_LOADED
  function __load_theme --on-event fish_prompt
    # Only run this once
    functions -e __load_theme
    set -g __FISH_THEME_LOADED 1
    fish_config theme choose "Rose Pine Moon"
  end
end
