# NeoVim Setup

## Install NeoVim from source on server
How to install NeoVim from GitHub repository on server such as JSC:
```bash
cd 
git clone https://github.com/neovim/neovim
cd neovim
make clean
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
```
Then you probably have to add neovim to path. 
