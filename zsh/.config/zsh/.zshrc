export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history

unsetopt PROMPT_SP

# load + start compinit
autoload -U compinit && compinit
# automatic cd into directory
setopt auto_cd
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

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

[ -s "/Users/darkristy/.bun/_bun" ] && source "/Users/darkristy/.bun/_bun"
