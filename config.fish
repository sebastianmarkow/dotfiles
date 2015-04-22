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

# node
set -x PATH (brew --prefix node)/bin $PATH

# python
# set -x PIP_REQUIRE_VIRTUALENV true
set -x VIRTUALFISH_COMPAT_ALIASES true
eval (python -m virtualfish)

function fish_prompt --description 'Write out the prompt'

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

        if set -q VIRTUAL_ENV
            echo -n -s "(" (basename "$VIRTUAL_ENV") ") "
        end

	switch $USER

	case root

		if not set -q __fish_prompt_cwd
			if set -q fish_color_cwd_root
				set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
			else
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
		end

		echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '

	case '*'

		if not set -q __fish_prompt_cwd
			set -g __fish_prompt_cwd (set_color $fish_color_cwd)
		end

		echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '> '

	end
end
