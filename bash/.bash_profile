[[ -r ~/.bashrc ]] && . ~/.bashrc
eval "$(rbenv init -)"

complete -C /usr/local/bin/terraform terraform
. $HOME/.asdf/asdf.sh
