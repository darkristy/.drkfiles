[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

source ${HOME}/.zsh_plugins.sh

export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history

unsetopt PROMPT_SP

# load + start compinit
autoload -U compinit && compinit
# automatic cd into directory
setopt autocd
# correct if completion is no possible
zstyle ':completion:*' completer _complete _approximate

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

source "$ZDOTDIR/zsh-functions.zsh"

zsh_add_file "zsh-exports.zsh"
zsh_add_file "zsh-aliases.zsh"

[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
