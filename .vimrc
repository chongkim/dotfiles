call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/linediff.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-scripts/tagbar'
Plug 'vim-syntastic/syntastic'
call plug#end()

set hidden incsearch ignorecase et ai si smarttab nu nobackup
set list lcs=tab:\ \ ,trail:•
set wildmenu wildmode=longest,list,full
set diffopt+=vertical

" for ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack!

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_checkers=['pylint']


set laststatus=2
set t_Co=256
set vb  " visual bell
set fo=trocqj  " tcq is default
" t = auto wrap using textwidth
" r = put comments on carriage return
" q = wrap on gq
" c = put comments on wrap
" o = put comments on o or O
" l = don't wrap on long lines
" j = remove comment on join line


" Note: use `:0Glog` to list history of the file

if has("autocmd")
  augroup VIMRC
    au!
    au BufWritePost ~/.vimrc nested source ~/.vimrc
    au BufWritePost ~/.gvimrc nested source ~/.gvimrc
    au BufWritePost ~/.vim/ckim.vim nested source ~/.vim/ckim.vim
    au BufReadPost .aliases set ft=zsh
    au BufReadPost requirements.txt set ft=config
    au BufReadPost *.cnf set ft=config
    au BufEnter * set cul
    au BufLeave * set nocul
  augroup END

  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

color grb256

hi DiffText guifg=white
hi WildMenu guifg=black
hi CursorLine ctermbg=NONE guibg=NONE
hi CursorLineNr cterm=NONE

function! SendKeysCommand(line)
  let line = a:line
  let line = substitute(shellescape(line), ";'$", "\\\\;'", "")
  call system("tmux send-keys -t :.0 -- x" . line . " ENTER")
endfunction

function! SendKeys(cmd, ...)
  let l:cmd = a:cmd
  if type(l:cmd) != v:t_list
    let l:cmd = [l:cmd]
  endif

  if a:0 == 0
    let l:cmd = filter(l:cmd, "len(v:val) > 0")
  endif

  for line in l:cmd
    call SendKeysCommand(line)
  endfor
endfunction

command! BD bp | bd #

let mapleader=' '
nnoremap <c-j> :m+<cr>
nnoremap <c-k> :m-2<cr>
nnoremap <leader>a :Ack!<Space>
nnoremap <silent> ce :silent call SendKeys(getline('.'))<cr>
nnoremap <silent> cp :silent call SendKeys(getline("'{", "'}"))<cr>
vnoremap <silent> <leader>c :<c-u>silent call SendKeys(getline("'<", "'>"), 1)<cr>
nnoremap <leader>d1 :diffget LOCAL<cr>
nnoremap <leader>d2 :diffget BASE<cr>
nnoremap <leader>d3 :diffget REMOTE<cr>
nnoremap <leader>do :diffoff<cr>
nnoremap <leader>dt :diffthis<cr>
nnoremap <leader>du :diffupdate<cr>
nnoremap <leader>eg :split ~/.gvimrc<cr>
nnoremap <leader>ej :e ~/Documents/journal.txt<cr>
nnoremap <leader>el :split ~/.vim/ckim.vim<cr>
nnoremap <leader>en :split ~/Documents/notes.txt<cr>
nnoremap <leader>ep :split ~/a.py<cr>
nnoremap <leader>es :split ~/a.sql<cr>
nnoremap <leader>ev :split ~/.vimrc<cr>
nnoremap <leader>ez :split ~/.zshrc<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gh :0Glog<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
vnoremap <leader>lt :Linediff<cr>
nnoremap <leader>lo :LinediffReset<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>t :TagbarToggle<cr><c-w>b
nnoremap <leader>w :set wrap!<cr>

source ~/.vim/ckim.vim
