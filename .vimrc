" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" Variables {{{
let mapleader = "\<Space>"
let s:is_windows = has('win32') || has('win64')
let s:is_nvim = has('nvim')
"}}}

" Setting up vim-plug as the package manager {{{
if !filereadable(expand("~/.vim/autoload/plug.vim"))
    echo "Installing vim-plug and plugins. Restart vim after finishing the process."
    silent call mkdir(expand("~/.vim/autoload", 1), 'p')
    execute "!curl -fLo ".expand("~/.vim/autoload/plug.vim", 1)." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif

if s:is_windows
  set rtp+=~/.vim
endif

call plug#begin('~/.vim/plugged')
let g:plug_url_format = 'https://github.com/%s.git'
"}}}

" Plugin settings {{{
if !s:is_windows
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim' "{{{
    nnoremap <leader>e :Files<cr>
    nnoremap <leader>E :History<cr>
    nnoremap <leader>b :Buffer<cr>
    nnoremap <leader>a :Ag<cr>
    nnoremap <leader>l :BLines<cr>
    nnoremap <leader>L :Lines<cr>
    nnoremap <leader>t :BTags<cr>
    nnoremap <leader>T :Tags<cr>
    nnoremap <leader>h :Helptags<cr>
  "}}}
else
  " too bad fzf doesn't support Windows... but we have the venerable ctrlp!
  Plug 'felikz/ctrlp-py-matcher'
  Plug 'kien/ctrlp.vim' "{{{
    nnoremap <leader>e :CtrlP<cr>
    nnoremap <leader>E :CtrlPMRUFiles<cr>
    nnoremap <leader>b :CtrlPBuffer<cr>
    nnoremap <leader>t :CtrlPBufTag<cr>
    nnoremap <leader>T :CtrlPTag<cr>
    nnoremap <leader>r :CtrlPRTS<cr>
    nnoremap <leader>l :CtrlPLine<cr>

    let g:ctrlp_match_window = 'bottom,order:btt,min:20,max:20,results:20'
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
          \ 'file': '\.pyc$\|\.pyo$',
          \ }
    let g:ctrlp_open_multiple_files = '1jr'
    let g:ctrlp_max_files = 0
    let g:ctrlp_lazy_update = 50
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    let g:ctrlp_buftag_types = { 'ant': '--language-force=ant' }
  "}}}
endif
Plug 'mhinz/vim-grepper' "{{{
  let g:grepper = {
      \ 'tools':     ['ag', 'csearch', 'findstr'],
      \ 'dispatch':  1,
      \ 'open':      1,
      \ 'switch':    0,
      \ 'jump':      0,
      \ 'ag': {
      \   'grepprg': 'ag --nogroup --nocolor --column',
      \   'grepformat': '%f:%l:%c:%m'
      \ },
      \ 'csearch': {
      \   'grepprg': 'csearch -n',
      \   'grepformat': '%f:%l:%m'
      \ }}

  nmap gs  <plug>(GrepperOperator)
  xmap gs  <plug>(GrepperOperator)
"}}}
Plug 'junegunn/vim-easy-align' "{{{
  xmap gl <Plug>(EasyAlign)
  nmap gl <Plug>(EasyAlign)
"}}}
Plug 'editorconfig/editorconfig-vim'
Plug 'saaguero/vim-utils'
Plug 'haya14busa/incsearch.vim' "{{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
"}}}
Plug 'kana/vim-textobj-user'
Plug 'saaguero/vim-textobj-pastedtext'
Plug 'konfekt/fastfold'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' } "{{{
  augroup VimFireplace
    autocmd FileType clojure nmap <buffer> <C-]> <Plug>FireplaceDjump
  augroup END
"}}}
Plug 'raimondi/delimitmate' "{{{
  let delimitMate_expand_cr = 1
"}}}
Plug 'terryma/vim-multiple-cursors' "{{{
  let g:multi_cursor_exit_from_insert_mode = 0
"}}}
Plug 'vim-scripts/matchit.zip'
Plug 'sirver/ultisnips', { 'on': [] } "{{{
  let g:UltiSnipsSnippetsDir = '~/.vim/plugged/vim-snippets/UltiSnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsListSnippets="<c-l>"

  inoremap <silent> <C-j> <C-r>=LoadUltiSnips()<cr>

  " This function only runs when UltiSnips is not loaded
  function! LoadUltiSnips()
    let l:curpos = getcurpos()
    execute plug#load('ultisnips')
    call cursor(l:curpos[1], l:curpos[2])
    call UltiSnips#ExpandSnippet()
    return ""
  endfunction
"}}}
Plug 'saaguero/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "{{{
  nnoremap <silent> <F4> :NERDTreeToggle<CR>
  nnoremap <silent> <F5> :NERDTreeFind<CR>
"}}}
Plug 'sjl/badwolf'
Plug 'endel/vim-github-colorscheme'
Plug 'vasconcelloslf/vim-interestingwords'
Plug 'davidhalter/jedi-vim', {'for': 'python'} "{{{
  " rely on tab trigger
  let g:jedi#completions_command = ""
  let g:jedi#popup_on_dot = 0
  " prevents jedi to mess with completeopt
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#use_tabs_not_buffers = 0
  let g:jedi#show_call_signatures = 0

  let g:jedi#goto_definitions_command = "<C-]>"
  let g:jedi#goto_assignments_command = "<leader>]"
  let g:jedi#usages_command = "<leader>u"
  let g:jedi#documentation_command = "K"
  let g:jedi#rename_command = "<leader>r"
"}}}

call plug#end()
"}}}

" Vim sensible settings {{{
set nocompatible
set encoding=utf-8
set listchars=trail:.,tab:>\ ,eol:$
set lazyredraw
set laststatus=2
set statusline=%-4m%f\ %y\ \ %=%{&ff}\ \|\ %{&fenc}\ [%l:%c]
set incsearch hlsearch
set nonumber
set backspace=indent,eol,start
set nostartofline
set autoread
set scrolloff=3
set wildmenu wildignorecase wildmode=list:longest,full
set cursorline
set ignorecase smartcase
set showmode showcmd
set shortmess+=I
set hidden
set history=1000
set complete-=i completeopt=menu
set splitright splitbelow
set display+=lastline
set foldenable foldmethod=syntax foldlevelstart=99
set ttimeoutlen=50
set switchbuf=useopen
set mouse=a
set breakindent
set autoindent
set smarttab

filetype plugin indent on
syntax on

" better backup, swap and undo storage {{{
set noswapfile
set backup
set undofile

set backupdir=~/.vim/dirs/backup
set undodir=~/.vim/dirs/undo
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif
"}}}
"}}}

" GUI & Terminal setttings {{{
if has("gui_running")
  if has("gui_macvim")
    set guifont=Consolas:h15
  elseif has("gui_win32")
    autocmd GUIEnter * simalt ~x " open maximize in Windows
    set guifont=Consolas:h11
  endif
  set guioptions= " disable all UI options
  set guicursor+=a:blinkon0 " disable blinking cursor
  set ballooneval
  autocmd GUIEnter * set novisualbell t_vb=
else
  set noerrorbells novisualbell t_vb=
  if !s:is_nvim
    set term=xterm
  endif
  set t_ut= " setting for looking properly in tmux
  let &t_Co = 256
  if s:is_windows " trick to support 256 colors and scroll in conemu
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
    inoremap <esc>[62~ <c-x><c-e>
    inoremap <esc>[63~ <c-x><c-y>
    nnoremap <esc>[62~ 3<c-e>
    nnoremap <esc>[63~ 3<c-y>
  endif
endif

colorscheme badwolf
"}}}

" Filetype settings {{{
augroup CustomFiletype
  autocmd!
  autocmd BufNewFile,BufRead *.html set filetype=html.htmldjango
  autocmd BufNewFile,BufRead *.wxs set filetype=wxs.xml
  autocmd BufNewFile,BufRead *.wxi set filetype=wxi.xml
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy

  autocmd FileType python,vim,yaml setlocal foldmethod=indent
  autocmd FileType vim setlocal keywordprg=:help omnifunc=syntaxcomplete#Complete
augroup END
"}}}

" Custom utils/mappings {{{
" rsi mappings
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-e> <End>

" Filter command history the same way as <Up> <Down> do
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" avoid common typos
command! -bang Q q<bang>
command! -bang W w<bang>

" replace ex mode map and use it for repeating 'q' macro
nnoremap Q @q

" save as sudo
cabbrev w!! w !sudo tee "%"

" easy system clipboard copy/paste
noremap <Leader>y "+y
noremap <Leader>Y "+Y
noremap <Leader>p "+p
noremap <Leader>P "+P

" visual paste without losing the copied content
xnoremap p "0p

" copy full file path to clipboard
nnoremap <silent><Leader>gp :let @+ = expand("%:p")<cr>

" easy window navigation
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <leader>\ <c-^>
nnoremap <silent> <leader>q :botright copen<cr>

" easy terminal navigation (for nvim)
if s:is_nvim
  tnoremap <esc><esc> <C-\><C-n>
endif

" cd to directory of current file
nnoremap <silent> <leader>cd :lcd %:p:h<CR>

augroup CustomUtils
  autocmd!
  " Open the file placing the cursor where it was
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif

  " Use xmllint for xml formatting if availabe
  if executable('xmllint')
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
  endif

  " Close preview window when leaving insert mode http://stackoverflow.com/a/3107159/854676
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

" clear the search buffer when hitting return
nnoremap <silent> <leader><cr> :nohlsearch<cr>

" cscope
nnoremap d<c-]> :cs find d <c-r>=expand("<cword>")<cr><cr>
nnoremap c<c-]> :cs find c <c-r>=expand("<cword>")<cr><cr>
nnoremap t<c-]> :cs find t <c-r>=expand("<cword>")<cr><cr>
nnoremap f<c-]> :cs find f <c-r>=expand("<cfile>")<cr><cr>

" source private vimrc file if available
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
