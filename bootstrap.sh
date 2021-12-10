# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# spaceship prompt
sh -c "$(git clone https://github.com/spaceship-prompt/spaceship-prompt.git \"$ZSH_CUSTOM/themes/spaceship-prompt\" --depth=1)"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/themes/spaceship.zsh-theme"

source $ZSH/oh-my-zsh.sh -y

# link dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
