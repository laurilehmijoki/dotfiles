set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Highlight hits
set hlsearch

" Show line numbers
set number 

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Save the current file and run it
map <F5> :call SaveAndRun()<CR>

" Disable the arrow keys in the normal mode – using them there only slows you down. Use hkjl instead.
noremap <Up>    <nop>
noremap <Down>  <nop>
noremap <Left>  <nop>
noremap <Right> <nop>

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

" Re-index the Command-T index on focus and file save
augroup CommandTExtension
  autocmd!
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " For Jekyll posts; its handy to write have auto-wrapping on blog texts
  au! BufNewFile,BufRead */_posts/*.html set textwidth=100
augroup END
