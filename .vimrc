set nocompatible " Disable VI compatibility
set hidden " Can open new buffer when current one has changes
set encoding=utf-8
let mapleader = ","

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

colorscheme molokai
hi Normal ctermbg=black
hi Normal ctermfg=white
" Color line number
hi LineNr ctermfg=red

" Set .py files to python types automatically
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.py  setfiletype python
augroup END

" General vim configuration
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" Always direcly write to the file so that hot reloading can better work
set backupcopy=yes

" Do case insensitive matching
set ignorecase 

" Keeps the same paste buffer
xnoremap p pgvy

"Toggle paste mode
set pastetoggle=<F4>

" Scroll off
set scrolloff=9999

" press Ctrl r to replace visual selection by something prompted
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" press t to add {% trans "" %} to visual selection (Django translation)
"vnoremap t c{% trans "<C-R>"" %}<ESC>

" press t to add strong jade to visual selection
"vnoremap t c#[strong <C-R>"]<ESC>

" press t to add { "" | translate } to visual selection (angular gettext)
vnoremap t c{{ '<C-R>"' \| translate }}<ESC>

" Press (shift)-tab to (un)indent visual selection
vmap <Tab> >gv
vmap <S-Tab> <gv

" Remap autocomplete to ctrl space
inoremap <Nul> <C-n>

" j down
" k up
" l RIGHT
" h left 

" Remap navigation keys
" nnoremap ç o
" nnoremap o k
" nnoremap k h
" nnoremap l j
" nnoremap m l
" vnoremap o k
" vnoremap k h
" vnoremap l j
" vnoremap m l


set number
" Toggle line number
:nmap <F5> :set invnumber<CR>
set wildmode=longest,list,full
set wildmenu
set mouse=a

" Delete trailing spaces
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.xml :%s/\s\+$//e
autocmd BufWritePre *.scala :%s/\s\+$//e
autocmd BufWritePre *.coffee :%s/\s\+$//e
autocmd BufWritePre *.jade :%s/\s\+$//e
autocmd BufWritePre *.less :%s/\s\+$//e
autocmd BufWritePre *.sh :%s/\s\+$//e
autocmd BufWritePre *.vue :%s/\s\+$//e
autocmd BufWritePre *.json :%s/\s\+$//e

autocmd BufEnter *.py :set filetype=python
"autocmd BufEnter *.html :set filetype=htmldjango.html
autocmd BufEnter *.html :set filetype=html
autocmd BufEnter * silent! lcd %:p:h " Set window path to file path

" Add dash (-) to autocomplete, search, etc...
autocmd BufEnter *.vue :set iskeyword+=-
autocmd BufEnter *.jade :set iskeyword+=-
autocmd BufEnter *.less :set iskeyword+=-
autocmd BufEnter *.css :set iskeyword+=-

" Clear search highlight
nmap <silent> ,, :nohlsearch<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map tab to switch between buffers.
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
" Delete current buffer without closing split
nnoremap <C-c> :bp\|bd#<CR>

"Change match (i.e. (,{,[...) color highlight
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Search config
set hlsearch

" Don't jump to next match when * is pressed
nnoremap * *``

"""""""""""""""""
" FOLDING STUFF "
"""""""""""""""""
" Folding
au BufReadPre *.py setlocal foldmethod=indent foldnestmax=2 foldlevel=1
au BufReadPre *.jade setlocal foldmethod=indent foldnestmax=10 foldlevel=1
au BufReadPre *.coffee setlocal foldmethod=indent foldnestmax=4 foldlevel=1
au BufReadPre *.php setlocal foldmethod=indent foldlevel=1
au BufReadPre *.js setlocal foldmethod=indent foldlevel=1
au BufReadPre *.vue setlocal foldmethod=indent foldnestmax=10 foldlevel=1
"au FileType python setlocal foldmethod=indent foldnestmax=2 foldlevel=1
" Fold / unfold 
noremap <Enter> za
" Preserve the behavior of Enter in commmand line window.
":autocmd CmdwinEnter * nnoremap <CR> <CR>
":autocmd BufReadPost quickfix nnoremap <CR> <CR>


" Fold / unfold EVERYTHING
nnoremap <F3> :call ToggleFold()<CR>
au BufEnter * let b:folded=1
function ToggleFold()
  if( b:folded == 0 )
      exec "normal! zM"
      let b:folded = 1
  else
      exec "normal! zR"
      let b:folded = 0
  endif
endfunction

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"set list lcs=tab:>-,trail:.

" Highlight string formatting in Python
hi pythonStrFormatting cterm=bold ctermbg=none ctermfg=magenta


" Split settings.
set splitbelow
set splitright
:nmap <F12> <C-w>=

" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"nnoremap L :Ag<SPACE>

" The Silver Searcher
" USELESS?
"if executable('ag')
  "" Use ag over grep
  "set grepprg=ag\ --nogroup\ --nocolor

  "" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  ""ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0

"endif


""""""""""""""""
" Plugin stuff "
""""""""""""""""


"""""""""
" CTAGS "
"""""""""
set tags=./tags;/
nnoremap <A-UP> <C-]>
nnoremap <A-DOWN> <C-T>
nnoremap <A-RIGHT> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" execute "set <M-k>=\ek"
" nnoremap <M-k> <C-]>
" execute "set <M-j>=\ej"
" nnoremap <M-j> <C-T>
" execute "set <M-l>=\el"
" nnoremap <M-l> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


""""""""""""""""""""
" Syntastic config "
""""""""""""""""""""

" Use a local eslint if possible
let s:local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(s:local_eslint, "^\/\\w") == ''
    let s:local_eslint = getcwd() . "/" . s:local_eslint
endif

function s:SetVueSyntastic()
  let g:syntastic_vue_checkers = ['eslint']
  if executable(s:local_eslint)
      " let g:syntastic_javascript_eslint_exec = local_eslint
      let g:syntastic_vue_eslint_exec = s:local_eslint
  endif
endfunction

function s:SetJsSyntastic()
  let g:syntastic_javascript_checkers = ['eslint']
  if executable(s:local_eslint)
      let g:syntastic_javascript_eslint_exec = s:local_eslint
  endif
endfunction

au BufNewFile,BufRead *.js call s:SetJsSyntastic()
au BufNewFile,BufRead *.vue call s:SetVueSyntastic()

let g:syntastic_python_checkers=['pep8', 'pylint']
" let g:syntastic_python_pylint_args="-f parseable -r n --rcfile=~/.pylintrc"
let g:syntastic_python_pylint_args="-f parseable -r n"
let g:syntastic_python_pep8_args='--max-line-length=100 --ignore=E265,E113,E731'

" Useful?
let g:syntastic_less_checkers=['less', 'lesslint']
let g:syntastic_less_use_less_lint=1

let g:syntastic_auto_loc_list=1  " Always show list of errors
let g:syntastic_mode_map={'mode': 'passive'}
let g:syntastic_loc_list_height=8
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_aggregate_errors = 1

map <F2> :w \| SyntasticCheck<CR>
map <F1> :SyntasticReset<CR>


""""""""""""""""""
" Airline config "
""""""""""""""""""
set laststatus=2

" Faster rendering when leaving escape mode
set ttimeoutlen=50
" Disable default mode indicator
set noshowmode

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '🍺'
let g:airline#extensions#tabline#left_alt_sep = '🍺'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_min_count = 2

" Git integration
"let g:airline_enable_branch=1
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_branch_prefix = '⎇ '
"let g:airline_paste_symbol = 'ρ'

" syntastic integration
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#syntastic#enabled = 1


""""""""""""""""""
" CtrlP config "
""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](bower_components|node_modules)$',
    \ 'file': '\v\.(pyc)$',
    \ }
let g:ctrlp_regexp = 1  " Default regex search
let g:ctrlp_by_filename=1  " Default search by filename
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:20,results:20'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


""""""""""""""""""
" NERDComment    "
""""""""""""""""""

map X <Leader>c<Space>
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
