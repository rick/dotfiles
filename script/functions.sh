describe() {
  echo "--- $1…"
}

squelch() {
  $@ > /dev/null 2>&1
}

log_for() {
  mkdir -p ./tmp/logs/
  touch ./tmp/logs/$1.log
  printf "./tmp/logs/$1.log"
}

daemonize() {
  $@
}

check_port() {
  if lsof -n -i :$1 > /dev/null; then
    printf "\nError! port $1 is already being used.\n"
    exit 1
  fi
}

pid_for() {
  mkdir -p ./tmp/pids
  touch "./tmp/pids/$1.pid"
  printf "./tmp/pids/$1.pid"
}

check_pid() {
  PID_FILE=$(pid_for $1)
  if ps -p $(<$PID_FILE) > /dev/null; then
    printf "\n Error! $1 already running \n"
    exit 1
  fi
}

git_branch_name() {
  set +u
  if [ -n "$CI" ]; then
    local branch=$BUILDKITE_BRANCH
  else
    local branch=$(git rev-parse --abbrev-ref HEAD)
  fi
  set -u
  printf "$branch"
}

kill_pid() {
  PID_FILE=$(pid_for $1)
  if ps -p $(<$PID_FILE) > /dev/null; then
    kill $(<$PID_FILE) > /dev/null
    describe "Killed $1 ($(<$PID_FILE))"
  fi
}

from_env() {
  local key=$1
  local value=$(cat .env | grep $key | sed 's/^[^=]*=//' | awk '{print $1}' | tr -d '"')
  printf $value
}

docker_backend_image_name() {
  local repo_name=$(from_env DOCKER_REPO)
  local build_name=$(from_env DOCKER_BUILD)
  printf "$repo_name/completecase:${build_name}"
}

docker_services_up() {
  local docker_compose_file=$1
  describe "Start docker services"
  docker-compose -f $docker_compose_file up -d
}

docker_services_down() {
  local docker_compose_file=$1
  describe "Stop docker services"
  docker-compose -f $docker_compose_file  down
}

brew_bundle_install() {
  if [ -f "${HOME}/Brewfile" ]; then
    brew bundle check || {
      describe "Install Homebrew dependencies"
      brew bundle
    }
  fi
}

asdf_bootstrap() {
  [ ! -d "$HOMEBREW_CELLAR/asdf" ] || {
    brew uninstall asdf
    describe "Uninstall asdf from homebrew"
  }
  [ -d "$HOME/.asdf" ] || {
    describe "Install asdf via git"
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    . $HOME/.asdf/asdf.sh
    echo '. $HOME/.asdf/asdf.sh' >> $HOME/.bash_profile
    asdf update
  }
}

asdf_add_plugins() {
  if [ -f .tool-versions ]; then
    describe "Add asdf language plugins"
    asdf plugin add python || true
    asdf plugin add nodejs || true
  fi
}

asdf_install_tools() {
  if [ -f .tool-versions ]; then
    describe "Install language versions"
    asdf install
  fi
}

asdf_update_plugins() {
  if [ -f .tool-versions ]; then
    describe "Update asdf language plugins"
    asdf plugin-update --all
  fi
}

python_update_pip() {
  describe "Update pip"
  pip3 install --upgrade pip
}

python_install_pipx() {
  describe "Install pipx"
  pip3 install pipx
}

python_install_poetry() {
  describe "Install poetry"
  pipx install poetry
}

python_add_home_local_bin_to_path_in_bash_profile() {
  local bin_local_path="$HOME/.local/bin"
  if [[ ":$PATH:" == *":$bin_local_path:"* ]]; then
    echo "$bin_local_path is already in the PATH variable."
  else
    echo "Adding $bin_local_path to .bash_profile you'll need to run 'source ~/.bash_profile'"
    echo 'export PATH="$PATH:/Users/thephw/.local/bin" # Python' >> $HOME/.bash_profile
  fi
}

python_update_poetry() {
  describe "Update poetry"
  pipx upgrade poetry
}

python_install_dependencies() {
  describe "Install python dependencies"
  poetry lock --no-update
}
