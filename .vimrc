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
set directory=~/.vim/.tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ignore (works as Command-T ignore list, for example)
set wildignore+=.git,*.class,.svn,*.jar,target,output

" Enable Vundle
" 1) Install Vundle with `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
" 2) Install bundles with :BundleInstall
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" After first Vundle run, finish the Command-T installation like so:
" 1) `cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb`
" 2) `cd ~/.vim/bundle/command-t/ruby/command-t && make`
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'https://github.com/kchmck/vim-coffee-script.git'
Bundle 'git://github.com/tpope/vim-surround.git'
Bundle 'https://github.com/groenewege/vim-less.git'
Bundle 'git://github.com/laurilehmijoki/haskellmode-vim.git'
Bundle 'https://github.com/mileszs/ack.vim'

runtime macros/matchit.vim

syntax on
colorscheme desert " wombat, slate, shady and peachpuff are also nice

" Enable file type detection; do language-dependent indenting
filetype plugin indent on

let mapleader = "," " , is more handy than the default leader \

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<cr>

" Disable the arrow keys in the normal mode – using them there only slows you down. Use hkjl instead.
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Esc is so far away without this mapping...
inoremap jj <Esc>
imap <C-c> <Esc>

map <Leader>a ggVG " Select all

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

" Hash rocket
imap <C-l> <space>=><space>
" For generators
imap <C-j> <space><-<space>

nmap <F3> :NERDTreeToggle()<cr>

" Load abbreviations
source ~/.vim/abbreviations_ruby.vim

call pathogen#infect()

" Alias frequently typo'ed commands
command! WQ wq
command! Wq wq
command! Wa wa
command! W w
command! Q q
command! Qa qa

" For quick editing of .vimrc
map <leader>v :vs $MYVIMRC<cr><C-W>
map <silent> <leader>V :source $MYVIMRC<cr>:filetype detect<cr>:exe ":echo 'vimrc reloaded'"<cr>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>r :call RunTestFile()<cr>
map <leader>R :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

augroup vimRcExtensions
  autocmd!
  " Open NERDTree if no args were given to VIM
  autocmd vimenter * if !argc() | NERDTree | wincmd l | endif

  " Look for template based on the file extension
  autocmd! BufNewFile * silent! 0r ~/.vim/templates/tmpl.%:e

  autocmd! BufNewFile,BufRead */*.scala set textwidth=80

  autocmd! BufNewFile,BufRead */*.md set filetype=Markdown

  autocmd! BufNewFile,BufRead */nginx/*.conf set ft=nginx

  autocmd! BufNewFile,BufRead */*.json set ft=javascript

  autocmd! BufNewFile,BufRead **/*.js set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.java set tabstop=4| set shiftwidth=4

  autocmd! BufNewFile,BufRead **/*.coffee set tabstop=2| set shiftwidth=2

  autocmd! BufNewFile,BufRead **/*.markdown,**/*.md set textwidth=80

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Will be slow with large set of files:
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush

  " Fix trailing whitespaces on every file write
  autocmd BufWritePost * :FixWhitespace

  " For the haskellmode plugin
  autocmd Bufenter *.hs compiler ghc | set cmdheight=1
augroup END
