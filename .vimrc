" my leader key
let mapleader = "\<Space>"

" setting up Vundle - the vim plugin bundler
let firstTimeVundle=0

let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    if has('win32')
        silent !mkdir \%HOMEPATH\%/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle \%HOMEPATH\%/.vim/bundle/vundle
    else
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    endif
    let firstTimeVundle=1
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'tomtom/tcomment_vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-dispatch'
Plugin 'tommcdo/vim-exchange'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'saaguero/vim-togglelist'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/matchit.zip'
Plugin 'gregsexton/gitv'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'saaguero/vim-snippets'
Plugin 'marijnh/tern_for_vim'
Plugin 'junegunn/seoul256.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'rking/ag.vim'
Plugin 'Peeja/vim-cdo'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/badwolf'
Plugin 'manuel-colmenero/vim-simple-session'
Plugin 'vim-scripts/mru.vim'
Plugin 'skwp/greplace.vim'
Plugin 'idbrii/vim-mark'
Plugin 'Shougo/neocomplete.vim'
Plugin 'kien/ctrlp.vim'

" installing plugins the first time
if firstTimeVundle == 1
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on

" Allow to complete on a single-match without showing the popup
set completeopt=menu
" no vi-compatible
set nocompatible
" tabs and spaces handling (default)
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" exceptions
augroup spaces
    autocmd!
    autocmd FileType html,xml,javascript set shiftwidth=2 tabstop=2 softtabstop=2
augroup END

" disabling Background Color Erase (BCE) for looking properly in tmux
set t_ut=
" disabling beeping and flashing on errors
augroup disable_beep
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=
augroup END
" always show status bar
set ls=2
set incsearch
set hlsearch
" syntax highlight on
syntax on
set number
" set backspace to work as expected
set backspace=2
" turn folding off
set nofoldenable
" if a file is changed outside of vim, automatically reload it without asking
set autoread
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3
" Complete next full match then cycle with tab.
set wildmode=full
set wildmenu
set cursorline
" ignorecase is needed for smartcase to work
set ignorecase
set smartcase
set showcmd
" avoid splashscreen
set shortmess+=I
set mouse=a
set textwidth=80
set colorcolumn=80
" allow to edit a file without saving current buffer
set hidden
" increase history, default is 20
set history=1000
" puts new split/vsplit right/below
set splitright
set splitbelow
" show matching brackets/parenthesis when closing in insert mode
" set showmatch

" gui setttings
if has("gui_running")
    if has("gui_macvim")
        set guifont=Consolas:h15
    elseif has("gui_win32")
        au GUIEnter * simalt ~x
        set guifont=Consolas:h11
    endif
    set guioptions=
else
    " use 256
    set term=xterm
    let &t_Co = 256
    if has('win32')
      " trick to support 256 colors in conemu for Windows
      let &t_AF="\e[38;5;%dm"
      let &t_AB="\e[48;5;%dm"
    endif
endif

colorscheme badwolf

" better backup, swap and undos storage
set noswapfile
set directory=~/.vim/dirs/swap
set backup
set backupdir=~/.vim/dirs/backups
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" tagbar settings
nnoremap <silent> <F3> :TagbarToggle<CR>

" easy scroll movement
noremap J 5j
noremap K 5k

" command typos, no more!
command! -bang Q q<bang>
command! -bang W w<bang>

" save as sudo
ca w!! w !sudo tee "%"

" easy system clipboard copy/paste
vmap <Leader>y "*y
nmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>d "*d
nmap <Leader>p "*p
nmap <Leader>P "*P
vmap <Leader>p "*p
vmap <Leader>P "*P

" easy windows navigation
nmap <silent> <c-l> <c-w>l
nmap <silent> <c-j> <c-w>j
nmap <silent> <c-h> <c-w>h
nmap <silent> <c-k> <c-w>k
nmap <silent> <Leader>s :sp<CR>
nmap <silent> <Leader>v :vsp<CR>
nmap <silent> <Leader>o :only<CR>
nmap <silent> <Leader>w :bw<CR>
nmap <silent> <Leader>W :bw!<CR>
nmap <silent> <f4> :NERDTree<CR>

" cd to directory of current file
nnoremap <silent> <leader>cd :cd %:p:h<CR>

" easy vimrc handling
nnoremap <leader>C :edit $MYVIMRC<cr>
nnoremap <leader>S :source $MYVIMRC<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" rehighlights the last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

augroup utils
    autocmd!
    " Open the file placing the cursor were it was
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif

    " filetype.vim (included in vim) hasn't have a good autodetection for
    " htmldjango. Therefore just rely on htmldjango for both django and html files
    autocmd BufNewFile,BufRead *.html set filetype=htmldjango

    autocmd BufNewFile,BufRead *.wxs set filetype=xml
    autocmd BufNewFile,BufRead *.md set filetype=markdown

    " Use xmllint for xml formatting (use gg=G to format the whole document)
    autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
augroup END

" TODO improve find in all files flow
" open grep and search recursively in current folder
map <leader>f :grep -Ir --exclude-dir="node_modules" "" *
                                                    \<left><left><left>
" clear the search buffer when hitting return
:nnoremap <silent> <leader><cr> :nohlsearch<cr>

" session settings, just save files and current directory
set sessionoptions=curdir

" seoul colorscheme settings
let g:seoul256_background = 233
let g:seoul256_light_background = 256

" vim-airline settings
let g:airline_theme = 'zenburn'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1

" vim-multiple-cursors settings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" vim-indent-guides settings
nnoremap <silent> <F2> :IndentGuidesToggle<cr>
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" delimitmate settings
let delimitMate_expand_cr = 2

" trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=black guibg=black
match ExtraWhitespace /\s\+$/
" map for cleaning trailing whitespace
nmap <F10> :%s/\s\+$//e<CR>

" mru settings
" open latest closed file
nmap <leader><S-e> :Mru<cr><cr>

" ultisnips settings. Fix to use other keys as it conflicts with YCM and others
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" neocomplete settings
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#enable_smart_case = 1
" use <tab> for triggering manual completion
function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
                   \ <SID>check_back_space() ? "\<TAB>" :
                   \ neocomplete#start_manual_complete()

" fugitive settings
" prevent bloat buffer list
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" ctrlp settings
let g:ctrlp_map = '<Leader>e'
" Use the directory you started vim
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

