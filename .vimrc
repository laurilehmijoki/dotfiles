set nocompatible
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
set statusline=%F%m%r%h%w\ (%Y)\ (%l/%L,%c)
set laststatus=2 " Always show the statusline on the 2nd last row
set incsearch " While typing a search, show where the pattern matches
set history=500
set pastetoggle=<F2> " The no-paste mode disables auto-indenting
set clipboard+=unnamed " Always yank/delete to system clipboard
set virtualedit=block

" Store temp files in a central spot
set backup
set backupdir=~/.vim/.tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/* " Otherwise crontab editing fails
set directory=~/.vim/.tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ignore (works as Command-T ignore list, for example)
set wildignore+=.git,*.class,.svn,*.jar,target,output,node_modules

" Enable Vundle
" 1) Install Vundle with `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
" 2) Install bundles with :BundleInstall
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'https://github.com/scrooloose/nerdtree'

syntax on
colorscheme desert " wombat, slate, shady and peachpuff are also nice

" Enable file type detection; do language-dependent indenting
filetype plugin indent on

let mapleader = "," " , is more handy than the default leader \

nmap <F3> :NERDTreeToggle()<cr>

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<cr>

" Search and replace word under cursor using F6
nnoremap <F6> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Disable the arrow keys in the normal mode – using them there only slows you down. Use hkjl instead.
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

nnoremap <C-e> 3<C-e> " Scroll the viewpoint faster
nnoremap <C-y> 3<C-y>

" Arrows resize windows
nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>

nmap <C-p> :bp<cr> " Previous buffer
nmap <C-n> :bn<cr> " Next buffer

" Locate the current file in NERDTree
nmap <leader>l :NERDTreeFind<cr>

" Alias frequently typo'ed commands
command! WQ wq
command! Wq wq
command! Wa wa
command! W w
command! Q q
command! Qa qa

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
inoremap <Tab> <C-R>=SmartTab()<cr>

" Save the current file and run it
function! SaveAndRun()
  " Save the file
  exe ":w"
  " Run it
  exe "!%:p"
endfunction
map <F5> :call SaveAndRun()<cr>

augroup vimRcExtensions
  autocmd!
  " Open NERDTree if no args were given to VIM
  autocmd vimenter * if !argc() | NERDTree | wincmd l | endif

  autocmd! BufNewFile,BufRead */*.md set filetype=Markdown

  autocmd! BufNewFile,BufRead */nginx/*.conf set ft=nginx

  autocmd! BufNewFile,BufRead */*.json set ft=javascript

  autocmd! BufNewFile,BufRead */*.hbs set ft=html

  autocmd! BufNewFile,BufRead */*.rs set ft=rust

  autocmd! BufNewFile,BufRead **/*.js set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.py set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.sass set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.java set tabstop=4| set shiftwidth=4

  autocmd! BufNewFile,BufRead **/*.coffee set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.markdown,**/*.md set textwidth=80

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Fix trailing whitespaces on every file write
  autocmd BufWritePost * :FixWhitespace
augroup END
