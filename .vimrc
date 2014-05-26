execute pathogen#infect()

au! BufWritePost *.rb call RunLastSpec()

set autoindent nobackup mouse=a nocompatible expandtab hidden bs=start,indent,eol
set ignorecase incsearch laststatus=2 modeline nrformats-=octal number
set list listchars=tab:>-,trail:•,precedes:<,extends:>
set ruler showcmd noswapfile
set visualbell nowritebackup wrap textwidth=0
set wildmenu wildmode=longest,list,full
set ttimeoutlen=200
syntax on
set autoread

if !exists("g:vimloaded")
  set ts=2 sw=2 sts=2
endif

filetype plugin indent on
if has("gui_running")
  set background=dark
  colo grb256
  highlight SignColumn guibg=black
  highlight Visual guibg=#505050
  highlight Type guifg=#ffff76
  highlight WildMenu guifg=black
  " colo mayansmoke
  set go-=rL "remove scrollbar
  set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h14
  set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
else
  set t_Co=256
  set background=dark
  colo grb256
  highlight SignColumn ctermbg=black
  " hi CursorColumn ctermbg=234
  " hi CursorLine ctermbg=234 cterm=none
  " hi rubyInclude ctermfg=57
  " hi detailedInterpolatedString ctermfg=141
endif

function! AddHashRocket()
  if(getline(".")[col(".")-2] == ' ')
    return "=>\<space>"
  else
    return "\<space>=>\<space>"
  endif
endfunction

function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()

function! ToggleUnderscore()
  if maparg('<space>', 'i') == '_'
    iunmap <space>
    return "underscore off"
  else
    imap <space> _
    return "underscore on"
  endif
endfunction

function! BufferDelete()
  execute "bp | sp | bn | bd"
endfunction

let g:vimloaded = 1
let g:paredit_mode = 1
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit = "horizontal"
let g:airline_powerline_fonts = 1
" let g:neocomplcache_enable_at_startup = 1
let g:syntastic_error_symbol='✘'
let g:syntastic_warning_symbol='☢'
let g:tagbar_type_snippets = {
  \ 'ctagstype' : 'snippets',
  \ 'kinds' : [
    \ 's:snippet'
  \ ]
\ }
let g:rspec_runner = "os_x_iterm"

map ss :w<cr>
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>gw :Gwrite<cr>
map <leader>gd :Gdiff<cr>
map <leader>rt :call RunCurrentSpecFile()<cr>
map <leader>rs :call RunNearestSpec()<cr>
map <leader>rl :call RunLastSpec()<cr>
map <leader>ra :call RunAllSpecs()<cr>
map <leader>ro :call UnsetLastSpecCommand()<cr>
map <leader>v :e $MYVIMRC<cr>
map <leader>s :source $MYVIMRC<cr>
map <leader>u :UltiSnipsEdit<cr>
map <leader>c :ConqueTermSplit bash<cr>
map <leader>p :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" map <leader>t :Tagbar<cr><c-w><c-w>
map <leader>t :TagbarOpenAutoClose<cr>
map <leader>n :NERDTreeToggle<cr>
map <leader>x :Xbit<cr>
map <esc>u :nohl<cr>
map <silent> <S-space> :foldclose<cr>
map <f1> <esc>
map cn :cn<cr>
map cp :cp<cr>
imap <f1> <esc>
imap %w %w()<left>
imap <c-a> <home>
imap <c-b> <left>
imap <c-e> <end>
imap <c-f> <right>
imap <c-l> <c-r>=AddHashRocket()<cr>
imap <nul> <esc>:echo ToggleUnderscore()<cr>a
map <nul> :echo ToggleUnderscore()<cr>
map <d-m-left> :tabprevious<cr>
map <d-m-right> :tabnext<cr>
cnoremap <c-a> <home>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <esc>b <s-left>
cnoremap <esc>f <s-right>

au! BufRead,BufNewFile *.html set ft=htmldjango
au! BufRead,BufNewFile *.md set ft=markdown
au! BufRead,BufNewFile *.rabl,Guardfile,Gemfile set ft=ruby
au! BufRead,BufNewFile *.hiccup set ft=clojure
" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cursorcolumn
"   " au WinLeave * setlocal nocursorline nocursorcolumn
" augroup END

command! BD call BufferDelete()
command! Ctags execute '!/usr/local/bin/ctags -R .'
