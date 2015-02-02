" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" Variables {{{
let mapleader = "\<Space>"
let s:is_windows = has('win32') || has('win64')
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
Plug 'ajh17/VimCompletesMe'
Plug 'haya14busa/incsearch.vim' "{{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
"}}}
Plug 'sjl/gundo.vim' "{{{
  nnoremap <leader>gu :GundoToggle<cr>
"}}}
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'Konfekt/FastFold'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'raimondi/delimitmate' "{{{
  let delimitMate_expand_cr = 2
"}}}
Plug 'kristijanhusak/vim-multiple-cursors' "{{{
  let g:multi_cursor_normal_maps  = {'f': 1, 't': 1, 'F': 1, 'T':1,
                                        \ 'c': 1, 'd': 1}
"}}}
Plug 'saaguero/vim-togglelist'
Plug 'vim-scripts/matchit.zip'
Plug 'majutsushi/tagbar' "{{{
  nnoremap <silent> <F3> :TagbarToggle<CR>
"}}}
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
  let NERDTreeShowHidden=1
"}}}
Plug 'endel/vim-github-colorscheme'
Plug 'sjl/badwolf'
Plug 'idbrii/vim-mark', { 'on': '<Plug>MarkSet' } " {{{
  nmap <Leader>m <Plug>MarkSet
"}}}
Plug 'kien/ctrlp.vim' "{{{
  nnoremap <leader>e :CtrlP<cr>
  nnoremap <leader>E :CtrlPCurFile<cr>
  nnoremap <leader>t :CtrlPBufTag<cr>
  nnoremap <leader>T :CtrlPTag<cr>
  nnoremap <leader>a :CtrlPBuffer<cr>
  nnoremap <leader>A :CtrlPMRUFiles<cr>

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
Plug 'felikz/ctrlp-py-matcher'
Plug 'justinmk/vim-gtfo'
Plug 'davidhalter/jedi-vim', {'for': 'python'} "{{{
  let g:jedi#popup_on_dot = 0
  " just rely on tab trigger
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

call plug#end()
"}}}

" Vim sensible settings {{{
set nocompatible
set encoding=utf-8
set listchars=trail:.,tab:>\ ,eol:$
set lazyredraw
set laststatus=2
set statusline=%-4m%f\ %y\ \ %=%{&ff}\ \|\ %{&fenc}\ \ [%l:%c]
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
set winwidth=80
set display+=lastline
set foldenable foldmethod=syntax foldlevelstart=99
set ttimeoutlen=50
set switchbuf=useopen
set mouse=a
set breakindent

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
  autocmd GUIEnter * set visualbell t_vb=
else
  set noerrorbells visualbell t_vb=
  set term=xterm
  set t_ut= " setting for looking properly in tmux
  set t_ti= t_te= " prevent vim from clobbering the scrollback buffer
  let &t_Co = 256
  if s:is_windows " trick to support 256 colors in conemu for Windows
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
  endif
endif

augroup CustomColors
  autocmd!
  autocmd ColorScheme * highlight CursorLine cterm=bold ctermbg=NONE gui=bold guibg=NONE
augroup END

colorscheme badwolf
"}}}

" Spaces and Filetype settings {{{
set autoindent
set expandtab smarttab
set tabstop=4 softtabstop=4 shiftwidth=4

augroup CustomFiletype
  autocmd!
  autocmd BufNewFile,BufRead *.html set filetype=html.htmldjango
  autocmd BufNewFile,BufRead *.wxs set filetype=wxs.xml
  autocmd BufNewFile,BufRead *.wxi set filetype=wxi.xml
  autocmd BufNewFile,BufRead *.md set filetype=markdown

  autocmd FileType html,xml,javascript set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType python,vim setlocal foldmethod=indent
  autocmd Filetype text setlocal textwidth=80
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

" Source selection or line (from sjl/dotfiles)
vnoremap <leader>S y:@"<cr>
nnoremap <leader>S ^vg_y:@"<cr>

" avoid common typos
command! -bang Q q<bang>
command! -bang W w<bang>

" replace ex mode map and use it for repeating last executed macro
nnoremap Q @@

" save as sudo
cabbrev w!! w !sudo tee "%"

" easy system clipboard copy/paste
noremap <Leader>y "*y
noremap <Leader>Y "*Y
noremap <Leader>p "*p
noremap <Leader>P "*P

" copy full file path to clipboard
nnoremap <silent><Leader>gp :let @+ = expand("%:p")<cr>

" easy window navigation
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <leader>\ <c-^>

" cd to directory of current file
nnoremap <silent> <leader>cd :lcd %:p:h<CR>

" easy vimrc handling
nnoremap <leader>cc :tabedit $MYVIMRC<cr>
nnoremap <leader>cs :source $MYVIMRC<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" rehighlights the last pasted text
nnoremap gb `[v`]

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

" split lines on whitespace
function! SplitOnSpace()
  execute "normal f\<space>i\r\e"
  " make it repeatable (requires vim-repeat)
  silent! call repeat#set("\<Plug>CustomSplitOnSpace")
endfunction
nnoremap <silent> <Plug>CustomSplitOnSpace :call SplitOnSpace()<cr>
nnoremap <silent> <leader>k :call SplitOnSpace()<cr>

" join lines (convenient mapping for my workflow)
nnoremap <silent> <leader>j J

" Use Ag as default grep if available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m
  command! -nargs=+ -bang Ag silent! grep <args> | redraw! | botright copen
endif

" source private vimrc file if available
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
