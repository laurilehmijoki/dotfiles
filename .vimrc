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

syntax on

filetype on
filetype plugin on
filetype indent on

let mapleader = "," " , is more handy than the default leader \

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Save the current file and run it
map <F5> :call SaveAndRun()<CR>

" Disable the arrow keys in the normal mode – using them there only slows you down. Use hkjl instead.
noremap <Up>    <nop>
noremap <Down>  <nop>
noremap <Left>  <nop>
noremap <Right> <nop>

nnoremap <C-e> 3<C-e> " Scroll the viewpoint faster
nnoremap <C-y> 3<C-y>

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

" Count the words in a range
function! Count_words() range
  let lnum = a:firstline
  let n = 0

  while lnum <= a:lastline
    let n = n + len(split(getline(lnum)))
    let lnum = lnum + 1
  endwhile
  echo "found ".n." words"
endfunction

if exists("CommandT")
  " Re-index the Command-T index on focus and file save
  augroup CommandTExtension
    autocmd!
    autocmd FocusGained * CommandTFlush
    autocmd BufWritePost * CommandTFlush
  augroup END
endif

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " For Jekyll posts; its handy to write have auto-wrapping on blog texts
  au! BufNewFile,BufRead */_posts/*.html set textwidth=100
augroup END
