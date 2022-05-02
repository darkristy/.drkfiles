unsetopt PROMPT_SP
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"


eval "$(starship init zsh)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
#   export PATH=/opt/homebrew/opt/ruby/bin:$PATH
#   export PATH=`gem environment gemdir`/bin:$PATH
# fi
