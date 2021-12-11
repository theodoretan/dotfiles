# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

export ZSH_CUSTOM="~/.oh-my-zsh/custom"

# spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# ZSH_THEME="spaceship"

source $ZSH/oh-my-zsh.sh -y

# link dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
