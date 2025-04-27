# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zshell plugins
source ~/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# zshell options
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# keybinds
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# alias
alias ls='ls --color=auto'

# extra paths and alias
export PATH=$HOME/go/bin:$PATH
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PATH=/opt/nvim/bin:$PATH
  export PATH=/opt/go/bin:$PATH
  export PATH=/opt/zig:$PATH
  export PATH=/opt/zls:$PATH
  export PATH=$HOME/.npm/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias zed-editor="open -a /Applications/Zed.app -n"
fi

# enable fzf in the shell
source <(fzf --zsh)

# npm config prefix
export NPM_CONFIG_PREFIX=~/.npm

# enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# initialize compinit for zsh
autoload -Uz compinit && compinit

# bun completions
[ -s "/home/bois/.bun/_bun" ] && source "/home/bois/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

