#!/bin/zsh

# install macOS software
if [[ $OSTYPE == 'darwin'* ]]; then
  # install xcode-select
  echo "Checking Xcode CLT..."
  xcode-select -p > /dev/null 2>&1
  if [[ $? != 0 ]]; then
    echo "installing Xcode CLT..."
    xcode-select --install
  else
    echo "XCode CLT already installed..."
  fi

  # install homebrew
  echo "Checking Homebrew..."
  which -s brew
  if [[ $? != 0 ]]; then
    echo "installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew already installed..."
  fi

  # install casks & brews
  echo "Checking casks & brews..."
  if brew bundle check | grep -q "can't satisfy"; then
    echo "installing casks & brews..."
    brew bundle install
  else
    echo "all casks & brews already installed..."
  fi
fi

# install oh-my-zsh 
echo "Checking oh-my-zsh..."
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  echo "installing oh-my-zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed..."
fi

# zsh theme
echo "Checking spaceship-prompt theme..."
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
if [[ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]]; then
  echo 'downloading spaceship-prompt theme...'
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"
else
  echo 'spaceship-prompt theme already downloaded...'
fi

# check if ~/.config/nvim exists
if [[ ! -d $HOME/.config/nvim ]]; then
  mkdir "$HOME/.config/nvim"
fi

# link dotfiles
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
if [[ $? != 0 ]]; then
  cp -n "$HOME/.zshrc" "$HOME/.zshrc.old"
  ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
fi

ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
if [[ $? != 0 ]]; then
  cp -n "$HOME/.tmux.conf" "$HOME/.tmux.conf.old"
  ln -sf "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
fi

ln -s "$HOME/dotfiles/init.vim" "$HOME/.config/nvim/init.vim"
if [[ $? != 0 ]]; then
  cp -n "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.old"
  ln -sf "$HOME/dotfiles/init.vim" "$HOME/.config/nvim/init.vim"
fi

# install vim-plug + plugins
echo "Checking vim-plug..."
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim ]]; then
  echo 'downloading vim-plug+plugins...'
  /bin/bash -c "$(curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
  /bin/bash -c "$(nvim --headless +PlugInstall +qa)"
else
  echo 'vim-plug is already downloaded...'
fi

# reload oh-my-zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh -y
