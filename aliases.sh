# Shell stuff
alias reload="exec $SHELL"
alias ll='ls -AlF'
alias la='ls -A'
alias ..="cd .."                      
alias ...="cd ../.." 
alias prev="cd -"                      
alias wa="watch -n 0.5"
start () { source $1/bin/activate; }

# neovim
alias n="nvim"

# tmux
alias tl="tmux ls"
alias tn="tmux new -s"
ta () {
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
