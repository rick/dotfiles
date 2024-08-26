alias ls='ls -GFh'
alias ll='ls -al'
alias unfuck-cameras='sudo killall VDCAssistant'

# docker
alias dps="docker ps -a --no-trunc"
alias kd="docker ps -a | awk '{print \$1}' | sed '1d; s,^\(.*\),docker stop \1; docker rm \1,' | sh -s -x"
alias dc="docker-compose"
