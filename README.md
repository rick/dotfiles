# dotfiles

_Files with dots?_

## Opinions

 - Track dotfiles with git
 - Use [GNU Stow](https://www.gnu.org/software/stow/) to manage installation (via symlinks)
 - Use [Homebrew](https://brew.sh/) to install some base software
 - Use 1Password CLI integration + templates for secrets
   - (See: https://developer.1password.com/docs/cli/secrets-config-files/)
   - No secrets in git repos

## Requirements

 - Have homebrew installed
 - Have 1Password CLI installed and authorized

## Installation

```bash
git clone
cd dotfiles
script/bootstrap
script/creds          # you'll want to set up your own credentials and 1p maps in templates
script/install
```

## Flow

- `script/bootstrap` will install base things via `brew bundle`
- `script/creds` will use 1Password CLI to fetch secrets and populate `private/*` from `templates/*`
- `script/install` will use `stow` to symlink files into your home directory

## Questions

 - "Where is the Brewfile?"
   - It's in `public/homebrew/Brewfile` and will be symlnked to ~/Brewfile after `script/bootstrap`
