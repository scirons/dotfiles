# Prompt

if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure

# Vi
set -o vi

export TERM="tmux-256color"
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="brave"

# Edit line in vim with ctrl-e:

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Change cursor shape for different vi modes.

function zle-keymap-select() {
  case $KEYMAP in
  vicmd) echo -ne '\e[1 q' ;;        # block
  viins | main) echo -ne '\e[5 q' ;; # beam
  esac
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

# History

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS  # Don't save duplicate lines
setopt SHARE_HISTORY     # Share history between sessions

# Aliases

alias vim=nvim
alias t=tmux
alias news=newsboat

alias ls='ls --color=auto'
alias la='ls -lathr'

alias rm=rm -i

alias e=exit

alias d='cd /Volumes/Documents/'
# alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias neofetch='neofetch --source $HOME/.config/neofetch/ascii'

# Completion

fpath+=~/.zfunc

if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)

    FPATH="$BREW_PREFIX/share/zsh-completions:$FPATH"

    ZSH_AUTOSUGGESTIONS="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    ZSH_HIGHLIGHTING="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)


    [[ -f $ZSH_AUTOSUGGESTIONS ]] && source "$ZSH_AUTOSUGGESTIONS"
    [[ -f $ZSH_HIGHLIGHTING ]] && source "$ZSH_HIGHLIGHTING"
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select

# Yazi wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
