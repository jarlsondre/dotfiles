# Dotfiles

## Plugins for Oh My Zsh

You can install the `Oh My Zsh` plugins as follows:

``` bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"
```

## Setting up p10k

After cloning the necessary libraries, you have to symlink the `p10k` config to get the
correct setup:

```bash
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
```
