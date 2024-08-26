syntax on

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set backup
if !isdirectory($HOME."/.vim/backups")
  silent !mkdir -p ~/.vim/backups >/dev/null 2>&1
endif

set backupdir=~/.vim/backups
set noswapfile
set writebackup
