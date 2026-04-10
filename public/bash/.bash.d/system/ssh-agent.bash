export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

ssh-add -l >/dev/null 2>&1
if [ $? -eq 2 ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

ssh-add -l >/dev/null || ssh-add
