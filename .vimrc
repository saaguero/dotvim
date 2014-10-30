" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" Variables {{{
let mapleader = "\<Space>"
let s:is_windows = has('win32') || has('win64')
"}}}

" Setting up vim-plug as the package manager {{{
if !filereadable(expand("~/.vim/autoload/plug.vim"))
    echo "Installing vim-plug..."
    silent call mkdir(expand("~/.vim/autoload", 1), 'p')
    execute "!curl -fLo ".expand("~/.vim/autoload/plug.vim", 1)." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    :qa!
endif

if s:is_windows
  set rtp+=~/.vim
endif

call plug#begin('~/.vim/plugged')
let g:plug_url_format = 'https://github.com/%s.git'
"}}}

" Plugin settings {{{
Plug 'ervandew/supertab' "{{{
  let g:SuperTabDefaultCompletionType = "context"
"}}}
Plug 'tomtom/tcomment_vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'Keithbsmiley/investigate.vim' "{{{
  let g:investigate_use_dash=1
"}}}
Plug 'bling/vim-airline' "{{{
  let g:airline_theme = 'zenburn'
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#tagbar#enabled = 0
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#disable_rtp_load = 1
"}}}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' "{{{
  " prevent bloat buffer list
  augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
"}}}
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tommcdo/vim-exchange'
Plug 'raimondi/delimitmate' "{{{
  let delimitMate_expand_cr = 2
"}}}
Plug 'kristijanhusak/vim-multiple-cursors' "{{{
  let g:multi_cursor_use_default_mapping=0
  let g:multi_cursor_next_key='<C-d>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-k>'
  let g:multi_cursor_quit_key='<Esc>'
"}}}
Plug 'saaguero/vim-togglelist'
Plug 'Yggdroot/indentLine' "{{{
  nnoremap <silent> <F2> :IndentLinesToggle<cr>
  let g:indentLine_char = '|'
  let g:indentLine_enabled = 0
"}}}
Plug 'vim-scripts/matchit.zip'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'majutsushi/tagbar' "{{{
  nnoremap <silent> <F3> :TagbarToggle<CR>
"}}}
Plug 'sirver/ultisnips', { 'on': [] } "{{{
  let g:UltiSnipsSnippetsDir = '~/.vim/plugged/vim-snippets/UltiSnips'
  let g:UltiSnipsExpandTrigger="<c-j>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsListSnippets="<c-l>"
  
  augroup load_ultisnips
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips') | autocmd! load_ultisnips
  augroup END
"}}}
Plug 'saaguero/vim-snippets'
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'junegunn/seoul256.vim' "{{{
  let g:seoul256_background = 233
  let g:seoul256_light_background = 256
"}}}
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } "{{{
  nnoremap <silent> <F4> :NERDTreeToggle<CR>
  nnoremap <silent> <F5> :NERDTreeFind<CR>
  let NERDTreeShowHidden=1
"}}}
Plug 'endel/vim-github-colorscheme'
Plug 'sjl/badwolf'
Plug 'idbrii/vim-mark'
Plug 'kien/ctrlp.vim' "{{{
  nnoremap <leader>e :CtrlP<cr>
  nnoremap <leader>E :CtrlPMRUFiles<cr>
  nnoremap <leader>t :CtrlPBufTag<cr>
  nnoremap <leader>T :CtrlPTag<cr>

  " Increase window height
  let g:ctrlp_match_window = 'bottom,order:btt,min:20,max:20,results:20'
  " Use the directory you started vim
  let g:ctrlp_working_path_mode = 0
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
        \ 'file': '\.pyc$\|\.pyo$',
        \ }

  " Do not clear filenames cache, to improve CtrlP startup
  " You can manualy clear it by <F5>
  let g:ctrlp_clear_cache_on_exit = 0
  " Set no file limit, we are building a big project
  let g:ctrlp_max_files = 0
  let g:ctrlp_lazy_update = 250
  " Use pymatcher to improve performance when filtering the resuls
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"}}}
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'felikz/ctrlp-py-matcher'
Plug 'justinmk/vim-gtfo'
Plug 'vim-scripts/html-autoclosetag'
Plug 'dkprice/vim-easygrep' "{{{
  " don't know why the next setting is not working
  " https://github.com/dkprice/vim-easygrep/issues/11
  let g:EasyGrepReplaceWindowMode = 2
  " Always Search or Replace Recursively
  let g:EasyGrepRecursive=1
  " Use grepprg
  let g:EasyGrepCommand = 1
  if executable('ag')
    set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
    set grepformat=%f:%l:%c:%m
  endif
"}}}
Plug 'saaguero/vim-scriptease', { 'for': 'vim' }
Plug 'scrooloose/syntastic' "{{{
  " disable executing on file save. use the command to run the checks
  let g:syntastic_mode_map = { "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }
  let g:syntastic_full_redraws = 0
"}}}
Plug 'davidhalter/jedi-vim', {'for': 'python'} "{{{
  let g:jedi#popup_on_dot = 0
  " just rely on supertab trigger
  let g:jedi#completions_command = ""
  " this prevents jedi to mess with completeopt
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#goto_assignments_command = "<leader>jg"
  let g:jedi#goto_definitions_command = "<leader>jd"
  let g:jedi#usages_command = "<leader>jn"
  let g:jedi#documentation_command = '<leader>jk'
  let g:jedi#rename_command = "<leader>jr"
"}}}
Plug 'ntpeters/vim-better-whitespace' "{{{
  nnoremap <F10> :StripWhitespace<cr>
  vnoremap <F10> :StripWhitespace<cr>
  highlight ExtraWhitespace ctermbg=black guibg=black
"}}}
Plug 'drmikehenry/vim-fontsize'

call plug#end()
"}}}

" Vim sensible settings {{{
set nocompatible
set encoding=utf-8
set listchars=trail:.,tab:>\ ,eol:$ " Chars to show when enabling 'set list'
set lazyredraw " Enhance operations like macros. See http://goo.gl/H8ch7c
set t_ut= " disabling Background Color Erase (BCE) for looking properly in tmux
set laststatus=2 " always show status bar
set incsearch
set hlsearch
set noerrorbells visualbell t_vb= " disable beeping and flashing on errors
autocmd GUIEnter * set visualbell t_vb= " for gvim
syntax on
set number
set backspace=2 " set backspace to work as expected
set autoread " automatically reload file if it changed
set scrolloff=3 " when scrolling, keep cursor 3 lines away from screen border
set wildmode=list:longest,full " Complete to common part then another <tab> will fully complete first match
set wildmenu
set wildignorecase
set cursorline
set ignorecase " ignorecase is needed for smartcase to work
set smartcase
set noshowmode " useful if using vim-airline as to avoid duplicating
set showcmd
set shortmess+=I " avoid splashscreen
set mouse=a
set textwidth=80
" allow to edit a file without saving current buffer set colorcolumn=80
set hidden
set history=1000 " increase history, default is 20
set shellslash " used forward slashes on Windows when expanding paths
set complete-=i " remove scanning include files for completion as it is slow
set completeopt=menu " only show completion popup on two or more options
set splitright splitbelow " puts new split/vsplit right/below
set display+=lastline " show as much as possible of the last line instead of @
set foldenable " enable folds by default
set foldmethod=syntax " fold via syntax of file
set foldlevelstart=99 " open all folds by default
" set tags=tags;/

filetype plugin indent on " allow plugins and auto indention for filetypes

" better backup, swap and undo storage {{{
" create needed directories if they don't exist
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

" Spaces and Filetype settings {{{
set autoindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" exceptions
augroup filetypeAndSpaces
  autocmd!
  autocmd FileType html,xml,javascript set shiftwidth=2 tabstop=2 softtabstop=2

  " filetype.vim (included in vim) hasn't have a good autodetection for
  " htmldjango. Therefore just rely on htmldjango for both django and html files
  autocmd BufNewFile,BufRead *.html set filetype=htmldjango
  autocmd BufNewFile,BufRead *.wxs set filetype=wxs.xml
  autocmd BufNewFile,BufRead *.wxi set filetype=wxi.xml
  autocmd BufNewFile,BufRead *.md set filetype=markdown

  autocmd FileType python setlocal foldmethod=indent
  autocmd FileType vim setlocal foldmethod=indent
augroup END
"}}}

" GUI setttings {{{
if has("gui_running")
  if has("gui_macvim")
    set guifont=Consolas:h15
  elseif has("gui_win32")
    au GUIEnter * simalt ~x
    set guifont=Consolas:h11
  endif
  set guioptions=
  " disable blinking cursor
  set guicursor+=a:blinkon0
else
  " use 256
  set term=xterm
  let &t_Co = 256
  if s:is_windows
    " trick to support 256 colors in conemu for Windows
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
  endif
endif

colorscheme badwolf
"}}}

" Custom utils/mappings {{{
" avoid common typos
command! -bang Q q<bang>
command! -bang W w<bang>

" suppress map for ex mode as it's easy to open it by mistake
nnoremap Q <nop>

" save as sudo
cabbrev w!! w !sudo tee "%"

" easy system clipboard copy/paste
vnoremap <Leader>y "*y
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p
nnoremap <Leader>P "*P
vnoremap <Leader>P "*P

" easy windows navigation
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <Leader>o :only<CR>
nnoremap <silent> <Leader>w :bd<CR>
nnoremap <silent> <Leader>W :bd!<CR>

" cd to directory of current file
nnoremap <silent> <leader>cd :cd %:p:h<CR>

" easy vimrc handling
nnoremap <leader>cc :edit $MYVIMRC<cr>
nnoremap <leader>cs :source $MYVIMRC<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" rehighlights the last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'


augroup utils
  autocmd!
  " Open the file placing the cursor where it was
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif

  " Use xmllint for xml formatting (use gg=G to format the whole document)
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

  " Fix for automatically closing preview window after leaving insert mode
  " From http://stackoverflow.com/a/3107159/854676
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

" clear the search buffer when hitting return
nnoremap <silent> <leader><cr> :nohlsearch<cr>

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
