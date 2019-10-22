# TODO: fixme
# # matches case insensitive for lowercase
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#
# # pasting with tabs doesn't perform completion
# zstyle ':completion:*' insert-tab pending

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/rick/Library/Caches/heroku/autocomplete/bash_setup && \
  test -f $HEROKU_AC_BASH_SETUP_PATH && \
  source $HEROKU_AC_BASH_SETUP_PATH
