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

# extra paths
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/nvim/bin:$PATH
export PATH=/opt/go/bin:$PATH

# enable fzf in the shell
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
