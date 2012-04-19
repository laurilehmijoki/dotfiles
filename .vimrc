set ignorecase " Eg /-style searches will ignore case
set smartcase
set title " In xterm, set the name of the current file as title
set scrolloff=3 " More context around cursor
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch " Highlight hits
set incsearch " ...dynamically as they are typed.
set number " Show line numbers
set ruler " Show position at the bottom right corner
set visualbell " Disable audio bell
set statusline=%F%m%r%h%w\ [type=%Y]\ [%p%%]\ [len=%L]
set laststatus=2 " Always show the statusline on the 2nd last row
set incsearch " While typing a search, show where the pattern matches
set cursorline " Underline the current line

" Store temp files in a central spot
set backup
set backupdir=~/.vim/.tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/.tmp,~/.tmp,~/tmp,/var/tmp,/tmp

syntax on
colorscheme slate " peachpuff is also nice

" Enable file type detection; do language-dependent indenting
filetype plugin indent on

let mapleader = "," " , is more handy than the default leader \

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Save the current file and run it
map <F5> :call SaveAndRun()<CR>

" Disable the arrow keys in the normal mode – using them there only slows you down. Use hkjl instead.
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Esc is so far away without this mapping...
inoremap jj <Esc>
imap <c-c> <Esc>

map <Leader>a ggVG " Select all

nnoremap <C-e> 3<C-e> " Scroll the viewpoint faster
nnoremap <C-y> 3<C-y>

nmap <C-p> :bp<CR> " Previous buffer
nmap <C-n> :bn<CR> " Next buffer

" Hash rocket
imap <c-l> <space>=><space>
" For generators
imap <c-j> <space><-<space>

" Load abbreviations
source ~/.vim/abbreviations_ruby.vim

" Alias frequently typo'ed commands
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa

" For quick editing of .vimrc
map <leader>v :vs $MYVIMRC<CR><C-W>
map <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Ctags
set tags=tags
map <F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --exclude=.git .<CR> :echo "ctags created/updated"<CR>
nmap <leader>j <C-]> " Jump to tag
nmap <leader>b <C-T> " Jump Back from tag
nmap <leader>J :ptselect<CR>
nmap <leader>n :tnext<CR>
nmap <leader>p :tprev<CR>
nmap <leader>o :TlistToggle<CR> " Toggle Taglist plugin's menu
" /Ctags

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

function! SmartTab() 
  if strpart( getline('.'), 0, col('.')-1 )=~ '^\s*$'
    " We are at the beginning of line or after a space
    return "\<Tab>"
  else
    " Use the known-word completion
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=SmartTab()<CR>

" Save the current file and run it
function! SaveAndRun()
  let cur_file_name = expand('%:p')
  let is_rspec_file =  matchstr(cur_file_name, '_spec\.rb') " Is an RSpec file?

  " Save the file
  exe ":w" 
  if is_rspec_file == ""
    " The file is not an RSpec file
    " Run it
    exe "!%:p" 
  else
    " Its an RSpec file
    exe "!rspec %:p"
  endif
endfunction

augroup vimRcExtensions
  autocmd!

  " Look for template based on the file extension
  autocmd! BufNewFile * silent! 0r ~/.vim/templates/tmpl.%:e

  autocmd! BufNewFile,BufRead */*.scala set textwidth=80

  " For Jekyll posts; its handy to write have auto-wrapping on blog texts
  autocmd! BufNewFile,BufRead */_posts/*.markdown set textwidth=80

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Will be slow with large set of files:
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END
