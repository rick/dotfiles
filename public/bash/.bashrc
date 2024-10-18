

# shortcut to this dotfiles path is $BASH
export BASH=$HOME/.bash.d


# clean up any symlinks which have gone dangling
find -L ${BASH} -type l -exec rm -- {} +

# load path files first
for file in $(find $BASH -type f -o -type l -name 'path.bash')
do
  source $file
done

# load in any function declarations
for file in $(find $BASH -type f -o -type l -name 'functions.bash')
do
  source $file
done

# load everything but the path and completion files
others=`find $BASH -type f -o -type l -name '*.bash' | grep -v -e completion.bash -e path.bash -e functions.bash`

for file in $others
do
  source $file
done

# load every completion after autocomplete loads
for file in $(find $BASH -type f -o -type l -name '*completion.bash')
do
  source $file
done

eval "$(/opt/homebrew/bin/brew shellenv)"
