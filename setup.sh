#!/bin/sh

# Setting up symbolic links
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/aliases.sh ~/.aliases
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim

# Setting up plugins for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || true
~/.tmux/plugins/tpm/bin/install_plugins

# Install uv if not present
if ! command -v uv >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Neovim Python environment
NVIM_VENV="$HOME/.local/share/nvim/python-env"
if [ ! -d "$NVIM_VENV" ]; then
    uv venv "$NVIM_VENV" --python 3.11
    uv pip install --python "$NVIM_VENV/bin/python" \
        pynvim jupyter_client ipykernel
fi
