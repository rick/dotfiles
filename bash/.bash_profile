[[ -r ~/.bashrc ]] && . ~/.bashrc

complete -C /opt/homebrew/bin/terraform terraform
. $HOME/.asdf/asdf.sh

eval "$(rbenv init - bash)"

