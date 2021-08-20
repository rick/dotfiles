
These are my dotfiles. I use [stow](https://www.gnu.org/software/stow/) to deploy dotfiles into my home
directory. I use [age](https://github.com/FiloSottile/age) to encrypt private dotfiles, which allows for storing
them securely in a git repository. My dotfiles are based around the Bash shell.

### using

 - Add your SSH public key(s) to your GitHub account.
 - Clone this repo to `~/.dotfiles`.
 - Put private dotfiles in `~/.dotfiles/private`.
   - Also, consider running `git init` inside the `~/.dotfiles/private` directory if you'd like to use `git` to track changes to the private dotfiles. This would never be separately pushed to a remote, but remote backup is provided via the enclosing dotfiles repository being pushed to GitHub.
 - Set your GitHub username (we pull your public SSH keys from GitHub to encrypt your private dotfiles):
```
export GITHUB_USER="your-username-here"
```
 - Run `script/encrypt` to create an encrypted tarball of your private dotfiles.
 - Push to GitHub.
 - Run `script/bootstrap` to put dotfiles in place, this will prompt for an SSH passphrase to decrypt private dotfiles.

To bring dotfiles to a new machine:
 - Add that machine's SSH pubkey to your GitHub account.
 - On a machine with dotfiles already checked out, run `script/encrypt` and push changes to GitHub.
 - Pull dotfiles to the new machine and run `script/bootstrap`.
