# bring in boxen's version of all the fancy git prompt stuff
source "${HOME}/.bash.d/system/vendor/git-prompt.sh"

# fancy prompt stuff

TEXT_BLACK='\[\e[0;30m\]' # Black - Regular
TEXT_RED='\[\e[0;31m\]' # Red
TEXT_GREEN='\[\e[0;32m\]' # Green
TEXT_YELLOW='\[\e[0;33m\]' # Yellow
TEXT_BLUE='\[\e[0;34m\]' # Blue
TEXT_PURPLE='\[\e[0;35m\]' # Purple
TEXT_CYAN='\[\e[0;36m\]' # Cyan
TEXT_WHITE='\[\e[0;37m\]' # White
# BLDBLK='\[\e[1;30m\]' # Black - Bold
# BLDRED='\[\e[1;31m\]' # Red
# BLDGRN='\[\e[1;32m\]' # Green
# BLDYLW='\[\e[1;33m\]' # Yellow
# BLDBLU='\[\e[1;34m\]' # Blue
# BLDPUR='\[\e[1;35m\]' # Purple
# BLDCYN='\[\e[1;36m\]' # Cyan
# BLDWHT='\[\e[1;37m\]' # White
# UNDBLK='\[\e[4;30m\]' # Black - Underline
# UNDRED='\[\e[4;31m\]' # Red
# UNDGRN='\[\e[4;32m\]' # Green
# UNDYLW='\[\e[4;33m\]' # Yellow
# UNDBLU='\[\e[4;34m\]' # Blue
# UNDPUR='\[\e[4;35m\]' # Purple
# UNDCYN='\[\e[4;36m\]' # Cyan
# UNDWHT='\[\e[4;37m\]' # White
# BAKBLK='\[\e[40m\]'   # Black - Background
# BAKRED='\[\e[41m\]'   # Red
# BAKGRN='\[\e[42m\]'   # Green
# BAKYLW='\[\e[43m\]'   # Yellow
# BAKBLU='\[\e[44m\]'   # Blue
# BAKPUR='\[\e[45m\]'   # Purple
# BAKCYN='\[\e[46m\]'   # Cyan
# BAKWHT='\[\e[47m\]'   # White
TEXT_RESET='\[\e[0m\]'    # Text Reset

# default:
# PS1="\h:\W \u\$ "

previous_exit_color() {
  if [ $1 -eq 0 ]; then
    echo -n "${TEXT_GREEN}" #▸${TEXT_RESET}"
  else
    #echo -n "${TEXT_RED}✘${TEXT_RESET}"
    echo -n "${TEXT_RED}" #▸${TEXT_RESET}"
  fi
}

export GIT_PS1_SHOWUPSTREAM="git verbose"
export GIT_PS1_DESCRIBE_STYLE="branch" # for (master~4) style
export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

if [[ $TERM_PROGRAM == 'iTerm.app' ]]; then
  # 0 means both tab and window, 1 is tab, 2 is window
  # see:
  #   http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss4.3
  #   http://www.mit.edu/afs/athena/system/x11r4/src/mit/clients/xterm/ctlseq2.txt via
  #   http://ubuntuforums.org/archive/index.php/t-448614.html
  TAB_NAME='\[\e]1;${PWD/#$HOME/~}\a\]'
  WINDOW_NAME='\[\e]2;\u@\h:${PWD/#$HOME/~}\a\]'
else
  TAB_NAME=''
  WINDOW_NAME=''
fi

PROMPT_HOST="${TEXT_PURPLE}$(hostname|sed 's|\..*||')${TEXT_RESET}";
if [[ `whoami` == 'root' ]]; then
USER_FLAG="${TEXT_RED}#${TEXT_RESET}"
else
USER_FLAG="${TEXT_GREEN}%${TEXT_RESET}"
fi

set_prompt(){
  status_color=$(previous_exit_color $?)
  history -a # append history after each command
  __git_ps1 "${TAB_NAME}${WINDOW_NAME}${TEXT_CYAN}\d \t${TEXT_RESET} ${PROMPT_HOST} ${TEXT_YELLOW}\w${TEXT_RESET}\n" " ${USER_FLAG} ${status_color}▸${TEXT_RESET} "
}

PROMPT_COMMAND=set_prompt
