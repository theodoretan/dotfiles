if [[ $SPIN -eq 1 ]]
then
  # dont run this stuff
else
  alias fun="cd ~/Documents/workspace"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the theme of zsh
ZSH_THEME="spaceship"

# Spaceship prompt config
SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ADD_NEWLINE=false

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# git aliases
alias fixpull="git prune remote origin"

# config aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim/init.vim"
alias tmuxconfig="vim ~/.tmux.conf"

# tmux aliases
alias worknew="tmux new -s code"
alias workattach="tmux attach -t code"

