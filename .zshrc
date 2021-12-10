# Path to your oh-my-zsh installation.
# export ZSH="~/.oh-my-zsh"

# Set the theme of zsh
ZSH_THEME="spaceship"

# Spaceship prompt config
SPACESHIP_PROMPT_PREFIXES_SHOW=false

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh -y

# aliases
# alias vim="nvim"
# alias vi="nvim"
# alias v="nvim"

# git aliases
alias fixpull="git prune remote origin"

# config aliases
alias zshconfig="vim ~/.zshrc"
# alias vimconfig="vim ~/.config/nvim/init.vim"
# alias tmuxconfig="vim ~/.tmux.conf"

# tmux aliases
# alias worknew="tmux new -s code"
# alias workattach="tmux attach -t code"

