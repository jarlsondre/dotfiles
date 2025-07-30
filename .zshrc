if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

plugins=(
	git 
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Assumes you have symlinked the dotfiles/aliases.sh file
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# macOS specific setup
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Autocomplete
  source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  # Adding homebrew to path
  export PATH=/opt/homebrew/bin:$PATH

  # Setting kubernetes config file
  export KUBECONFIG=/Users/jarl/.kube/config
fi


export GPG_TTY=$(tty)

# Setting up pyenv to work in the terminal
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Making the outputs of commands appear in the terminal rather than a new editor
export PAGER=cat

# Setting up Fzf (if it exists)
if command -v fzf > /dev/null; then
  source <(fzf --zsh)
fi

# Ensure ~/.local/bin is in PATH so user-installed tools (e.g., pip --user) are found.
# This logic adds it only if it's not already present, and prepends it to give priority.

# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed binary needs to be overridden
        export PATH="$HOME/.local/bin:$PATH"
        ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
