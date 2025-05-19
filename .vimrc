" vim: fdm=marker ts=2 sts=2 sw=2

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
    " TIP: on multiple selections, fzf populates the quickfix list
    " Select all with <alt-a> and deselect all with <alt-d>
    " With <tab> and <shift-tab> you can select individual items
    nnoremap <leader>e :Files<cr>
    nnoremap <leader>E :History<cr>
    nnoremap <leader>b :Buffer<cr>
    nnoremap <leader>a :Rg<cr>
    nnoremap <leader>L :Lines<cr>
    nnoremap <leader>t :BTags<cr>
    nnoremap <leader>T :Tags<cr>
    nnoremap <leader>h :Helptags<cr>

    " search current word with Rg
    nnoremap <leader>w :let @/=expand('<cword>')<cr> :Rg <C-r>/<cr>

    " add preview window, install https://github.com/sharkdp/bat.git for syntax-highlighting
    " if you aren't in fullscreen, press '?' to display it
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>,
      \                    <bang>0 ? fzf#vim#with_preview('up:75%')
      \                            : fzf#vim#with_preview('right:50%:wrap:hidden', '?'),
      \                    <bang>0)

    command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
  "}}}
else
  " fzf is supported in Windows, specially if you use WSL
  " but I haven't tried it yet. In the meantime we have the venerable ctrlp!
  Plug 'felikz/ctrlp-py-matcher'
  Plug 'kien/ctrlp.vim' "{{{
    nnoremap <leader>e :CtrlP<cr>
    nnoremap <leader>E :CtrlPMRUFiles<cr>
    nnoremap <leader>b :CtrlPBuffer<cr>
    nnoremap <leader>t :CtrlPBufTag<cr>
    nnoremap <leader>T :CtrlPTag<cr>
    nnoremap <leader>L :CtrlPLine<cr>

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
Plug 'lifepillar/vim-mucomplete' "{{{
  inoremap <silent> <plug>(MUcompleteFwdKey) <right>
  imap <right> <plug>(MUcompleteCycFwd)
  inoremap <silent> <plug>(MUcompleteBwdKey) <left>
  imap <left> <plug>(MUcompleteCycBwd)
"}}}
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-scriptease'
Plug 'xtal8/traces.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align' "{{{
  " Align everything, since by default it doesn't align inside a comment
  let g:easy_align_ignore_groups = []
  let g:easy_align_delimiters = {
    \ ';': { 'pattern': ';', 'left_margin': 0, 'stick_to_left': 1 } }
  xmap gl <Plug>(LiveEasyAlign)
  nmap gl <Plug>(LiveEasyAlign)
"}}}
Plug 'editorconfig/editorconfig-vim'
if ! has('patch-8.0.1238')
  " If you're using an old Vim without incsearch, replace it with:
  Plug 'haya14busa/incsearch.vim' "{{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  "}}}
endif
Plug 'kana/vim-textobj-user'
Plug 'saaguero/vim-textobj-pastedtext'
Plug 'konfekt/fastfold'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired' "{{{
  " custom unimpaired-like mappings
  nnoremap yog :GitGutterToggle<cr>
"}}}
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
  " Easy multiple cursors under word or selection
  nnoremap <leader>n :MultipleCursorsFind \<<C-r>=expand('<cword>')<CR>\><cr>
  vnoremap <leader>n :<C-u>MultipleCursorsFind <C-r>=GetVisualSelection()<CR><cr>
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
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree' "{{{
  let NERDTreeShowHidden=1
  nnoremap <leader>f :NERDTreeToggle<CR>
  nnoremap <leader>F :NERDTreeFind<CR>
"}}}
Plug 'sjl/badwolf'
Plug 'bluz71/vim-moonfly-colors'
Plug 'tomasiser/vim-code-dark'
Plug 'endel/vim-github-colorscheme'
Plug 'vasconcelloslf/vim-interestingwords' "{{{
  let g:interestingWordsDefaultMappings = 0
  nnoremap <silent> <leader>i :call InterestingWords('n')<cr>
  vnoremap <silent> <leader>i :call InterestingWords('v')<cr>
  nnoremap <silent> <leader>I :call UncolorAllWords()<cr>
  nnoremap <silent> n :call WordNavigation(1)<cr>
  nnoremap <silent> N :call WordNavigation(0)<cr>
"}}}
Plug 'Valloric/ListToggle' "{{{
  let g:lt_location_list_toggle_map = '<leader>Q'
  let g:lt_quickfix_list_toggle_map = '<leader>q'
"}}}
Plug 'AndrewRadev/linediff.vim' "{{{
  autocmd User LinediffBufferReady nnoremap <buffer> q :LinediffReset<cr>
  autocmd User LinediffBufferReady setlocal nocursorline
  nnoremap <leader>d :Linediff<cr>
  xnoremap <leader>d :Linediff<cr>
"}}}
Plug 'christoomey/vim-tmux-navigator' "{{{
  let g:tmux_navigator_save_on_switch = 1
"}}}
Plug 'github/copilot.vim'
Plug 'sheerun/vim-polyglot'
Plug 'prabirshrestha/vim-lsp' "{{{
  let g:lsp_diagnostics_enabled = 0

  set tagfunc=lsp#tagfunc
  nmap gd <plug>(lsp-definition)
  nmap gs <plug>(lsp-document-symbol-search)
  nmap gS <plug>(lsp-workspace-symbol-search)
  " nmap gr <plug>(lsp-references)
  nmap gi <plug>(lsp-implementation)
  nmap gt <plug>(lsp-type-definition)
  nmap gr <plug>(lsp-rename)
  nmap [g <plug>(lsp-previous-diagnostic)
  nmap ]g <plug>(lsp-next-diagnostic)
  nmap K <plug>(lsp-hover)
"}}}
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'easymotion/vim-easymotion' "{{{
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  let g:EasyMotion_smartcase = 1
  nmap <leader>s <Plug>(easymotion-overwin-f2)
  nmap <leader>j <Plug>(easymotion-w)
  nmap <leader>k <Plug>(easymotion-b)
"}}}
call plug#end()
"}}}

" Vim sensible settings {{{
set nocompatible
set encoding=utf-8
set listchars=trail:.,tab:>\ ,eol:$
set lazyredraw
set laststatus=2
set statusline=%-4m%f\ %y\ \ %=%{&ff}\ \|\ %{&fenc}\ [%l/%L:%c]
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
set updatetime=500
set synmaxcol=400
if has('patch-7.4.2201') | set signcolumn=yes | endif

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
  set t_BE= " disable bracketed-paste mode
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

colorscheme codedark "{{{
  " Custom colors
  " highlight DiffText cterm=bold ctermfg=255 ctermbg=196
  " highlight lspReference ctermfg=brown guifg=brown ctermbg=black guibg=brown
"}}}

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
" execute macro over visual selection
xnoremap Q :'<,'>:normal @q<cr>

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
nnoremap <silent><Leader>gp :let @+ = expand("%:p")<cr>:echo "File path copied!"<cr>

" easy add file execution permissions
nnoremap <silent><leader>gx :silent !chmod +x %<cr>:redraw!<cr>:echo "Executed: chmod +x " . expand("%")<cr>

" make c-f the same as our terminal hotkey to handle tmux sessions
nnoremap <c-f> :silent !tmux neww tmux-sessionizer<cr>:redraw!<cr>

" convenient grep command with sane defaults, populates the quickfix list
command! -nargs=+ Grep execute 'grep -I --exclude-dir=.{git,svn.hg} --exclude=tags <args>'
nnoremap <leader>u :Grep -r "" . <left><left><left><left>

" easy window navigation
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <leader>l <c-^>

" easy terminal navigation
if has('terminal') || s:is_nvim
  tnoremap <esc><esc> <C-\><C-n>
  tnoremap <PageUp> <C-W>N<C-U>
endif

" cd to directory of current file
nnoremap <silent> <leader>cd :lcd %:p:h<CR>

" easy replace every match in the quickfix list
nnoremap <leader>x :cdo s/<C-r>///g \| update<left><left><left><left><left><left><left><left><left><left><left>

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

  " Automatically equalize splits when Vim is resized
  autocmd VimResized * wincmd =
augroup END

" clear the search buffer when hitting <leader><cr>
nnoremap <silent> <leader><cr> :nohlsearch<cr>

" easier mappings for navigating the quickfix list
nnoremap <silent> <A-up> :cprevious<cr>
nnoremap <silent> <A-down> :cnext<cr>

" On wrapped long lines it's much easier to use gj and gk
noremap <expr> k v:count == 0 ? 'gk' : 'k'
noremap <expr> j v:count == 0 ? 'gj' : 'j'

" source vimscript operator
function! SourceVimscript(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @"

    if a:type == 'line'
        silent execute "normal! '[V']y"
    elseif a:type == 'char'
        silent execute "normal! `[v`]y"
    elseif a:type == "visual"
        silent execute "normal! gvy"
    elseif a:type == "currentline"
        silent execute "normal! yy"
    endif

    let @" = substitute(@", '\n\s*\\', '', 'g')

    " source the content
    @"

    let &selection = sel_save
    let @" = reg_save
endfunction

nnoremap <silent> <leader>v :set opfunc=SourceVimscript<CR>g@
vnoremap <silent> <leader>v :<C-U>call SourceVimscript("visual")<CR>
nnoremap <silent> <leader>vv :call SourceVimscript("currentline")<CR>
nnoremap <silent> <leader>vs :source $MYVIMRC<cr>
nnoremap <silent> <leader>ve :e $MYVIMRC<cr>

" split lines on whitespace
" repeatable (requires vim-repeat)
function! SplitOnSpace()
  let current_char = getline('.')[col('.') - 1]
  if current_char == ' '
    execute "normal i\r\e"
  else
    execute "normal f\<space>i\r\e"
  endif
  silent! call repeat#set("\<Plug>CustomSplitOnSpace")
endfunction

nnoremap <silent> <Plug>CustomSplitOnSpace :call SplitOnSpace()<cr>
nnoremap <silent> <leader>\ :call SplitOnSpace()<cr>

function! GetVisualSelection()
  let old_reg = @v
  normal! gv"vy
  let raw_search = @v
  let @v = old_reg
  return substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction

" Easy search/replace (from romainl/dotvim)
nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/
vnoremap <leader>r :<C-u>%s/<C-r>=GetVisualSelection()<CR>/

function! FormatJsonFun(a1, a2)
  if a:a1 == a:a2
    .!python -m json.tool
  else
    execute a:a1 . "," . a:a2 . "!python -m json.tool"
  endif
  normal! gg=G
endfunction

command! -range FormatJson call FormatJsonFun(<line1>, <line2>)

function! RunCommand()
    let s:sel = GetVisualSelection()
    let s:result = system(s:sel)
    if !v:shell_error
        set paste
        execute "normal gvc" . s:result
        set nopaste
    else
        echom 'Error executing command: ' . s:sel
    endif
endfunction

" Run bash command
nnoremap <leader>! !!bash<cr>
vnoremap <leader>! :<c-u>call RunCommand()<cr>

" makes * and # work on visual mode. Taken from nelstrom/vim-visual-star-search
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" source private vimrc file if available
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
"}}}
