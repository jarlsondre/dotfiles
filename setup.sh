#!/bin/sh

# Setting up symbolic links
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/aliases.sh ~/.aliases
ln -sf ~/dotfiles/.latexmkrc ~/.latexmkrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh

mkdir -p ~/.config
ln -sfn ~/dotfiles/nvim ~/.config/nvim

# LaTeX style file (TEXMFHOME is ~/Library/texmf on macOS, ~/texmf on Linux)
if [ "$(uname)" = "Darwin" ]; then
    TEXMF_LOCAL="$HOME/Library/texmf/tex/latex/local"
else
    TEXMF_LOCAL="$HOME/texmf/tex/latex/local"
fi
mkdir -p "$TEXMF_LOCAL"
ln -sf ~/dotfiles/mymathstyle.sty "$TEXMF_LOCAL/mymathstyle.sty"

# macOS-specific setup (aerospace, sketchybar etc. only work on macOS)
if [ "$(uname)" = "Darwin" ]; then
    ln -sfn ~/dotfiles/ghostty ~/.config/ghostty
    ln -sfn ~/dotfiles/sketchybar ~/.config/sketchybar
    ln -sfn ~/dotfiles/aerospace ~/.config/aerospace
    ln -sfn ~/dotfiles/karabiner ~/.config/karabiner
fi

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
