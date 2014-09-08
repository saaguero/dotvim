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

Bundle 'gmarik/vundle'
Bundle 'tomtom/tcomment_vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rsi'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-dispatch'
Bundle 'tommcdo/vim-exchange'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'saaguero/vim-togglelist'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'vim-scripts/matchit.zip'
Bundle 'gregsexton/gitv'
Bundle 'majutsushi/tagbar'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'godlygeek/tabular'
Bundle 'SirVer/ultisnips'
Bundle 'saaguero/vim-snippets'
Bundle 'marijnh/tern_for_vim'
Bundle 'junegunn/seoul256.vim'
Bundle 'junegunn/goyo.vim'
Bundle 'rking/ag.vim'
Bundle 'Peeja/vim-cdo'
Bundle 'vim-scripts/DirDiff.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/badwolf'
Bundle 'manuel-colmenero/vim-simple-session'
Bundle 'vim-scripts/mru.vim'
Bundle 'skwp/greplace.vim'
if has('win32')
    " Replaces fzf in windows
    Bundle 'kien/ctrlp.vim'
else
    Bundle 'junegunn/fzf'
    Bundle 'Valloric/YouCompleteMe'
endif

" installing plugins the first time
if firstTimeVundle == 1
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on

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
" first tab complete as much as possible, second provide a list,
" third and subsequent tabs cycle so you can complete the file
set wildmode=longest,list,full
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

" ultisnips settings. Fix to use other keys as it conflicts with YCM
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" YouCompleteMe settings
if !has('win32')
    let g:ycm_auto_trigger = 0
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:EclimCompletionMethod = 'omnifunc'
endif
augroup completion
    autocmd!
    " Indent if we're at the beginning of a line. Else, do completion
    function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        else
            return "\<c-p>"
        endif
    endfunction
    au Filetype * inoremap <tab> <c-r>=InsertTabWrapper()<cr>
    au Filetype * inoremap <s-tab> <c-n>
augroup END

" fugitive settings
" prevent bloat buffer list
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

if has('win32')
    " ctrlp settings
    let g:ctrlp_map = '<Leader>e'
    " Use the directory you started vim
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
      \ 'file': '\.pyc$\|\.pyo$',
      \ }
else
    " fzf settings
    nnoremap <Leader>e :FZF<CR>
endif

" custom scripts

" rehighlights the last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" From Steve Losh vimrc
" Highlight Word - Works only with badwolf colorscheme
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.
function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
nnoremap <silent> <leader>0 :call clearmatches()<cr>

" http://stackoverflow.com/a/1470179/854676
" Gets information about the current highlighting under the cursor
map <F5> :echom "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
            \ '> trans<' . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
            \ ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
