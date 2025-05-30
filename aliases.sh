# Shell stuff
alias reload="exec $SHELL"
alias ..="cd .."                      
alias ...="cd ../.." 
alias prev="cd -"                      
alias wa="watch -n 0.5"
start () { source $1/bin/activate; }

# NeoVim
alias n="nvim"

# tmux
alias tl="tmux ls"
alias tn="tmux new -s"
ta() {
  if [ $# -eq 0 ]; then
    tmux attach
  else
    tmux attach -t "$1"
  fi
}

# Git
alias ga="git add ."
alias gs="git status"
alias gc="git commit -m"

# Alias for listing changed Python files
alias gcpy='git diff --name-only HEAD -- "*.py"'

# Alias for linting changed Python files with ruff, using gcpy
glpy() {
  local files=$(gcpy)
  if [[ -n "$files" ]]; then
    echo "$files" | xargs ruff check
  else
    echo "No changed Python files to lint."
  fi
}

