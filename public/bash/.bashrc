# shortcut to this dotfiles path is $BASH
export BASH=$HOME/.bash.d

# load every completion after autocomplete loads
for file in $(find $BASH -type f -o -type l -name 'completion.bash')
do
  source $file
done
