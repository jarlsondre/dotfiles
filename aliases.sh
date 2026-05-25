# Shell stuff
alias reload="exec $SHELL"
alias ll='ls -AlF'
alias la='ls -A'
alias ..="cd .."                      
alias ...="cd ../.." 
alias prev="cd -"                      
alias wa="watch -n 0.5"
start () { source $1/bin/activate; }

# slurm stuff
alias sq='squeue -u "$USER" -o "%.10i %.12j %.8a %.10u %.4D %.5C %.11m %.8M %.6t %.12r %.20S %.20N" -S S'
wsq() {
  watch -n 0.5 -x squeue -u "$USER" \
    -o "%.10i %.12j %.8a %.10u %.4D %.5C %.11m %.8M %.6t %.12r %.20S %.20N" -S S
}

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
alias gp="git push"

# Use ripgrep to search for files matching a regex. Use: 'rgf my_search_string'
alias rgf='rg --files | rg'
