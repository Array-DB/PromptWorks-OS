export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nano"
export VISUAL="nano"

alias ll="ls -lah"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git pull"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias py="python"
alias pw-status="pw status"

autoload -Uz compinit && compinit
