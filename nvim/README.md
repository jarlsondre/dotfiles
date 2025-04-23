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

To add neovim to your path, add the following line to your configuration file:
```bash
echo 'export PATH="$HOME/neovim/bin:$PATH"' >> ~/.bashrc
```
If you don't use `bash`, then make sure to change out  `.bashrc` with the appropriate
configuration file.

Then, you can restart your shell with the following command:
```bash
exec $SHELL
```

## Troubleshooting
In this part I will (hopefully) add any troubleshooting steps that I encounter while
doing this installation:

- You encounter the following error: `as: unrecognized option '--gdwarf-5'`
  
  In this case, I found that there was a mismatch between the `gcc` version and the `as`
  version (whatever `as` is). Solution: Install a different version of `binutils`. In my
  case, I installed the right version as follows:

  ```bash
  module load binutils/2.42-GCCcore-13.3.0
  ```
  Note that this was because I saw that I add loaded this particular version of `GCCcore`,
  so if you're using a different version then you might have to change out the version.
