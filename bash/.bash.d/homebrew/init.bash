if  [ "$(uname -m)" == "arm64" ]; then
  eval $(/usr/local/bin/brew shellenv)
else
  eval $(brew shellenv)
fi
