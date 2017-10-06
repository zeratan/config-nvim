" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" easier moving between tabs
noremap <Leader>n <esc>:tabprevious<CR>
noremap <Leader>m <esc>:tabnext<CR>
noremap <Leader>t <esc>:tabe<CR>

" Make and cope
noremap <Leader>c <esc>:wa<CR>:make -f Makefile.user tests <bar> <CR>:cope<CR>
noremap <Leader>d <esc>:wa<CR>:make -f Makefile.user main <bar> <CR>:cope<CR>

" Niffler
noremap <Leader><c-p> <esc>:NifflerBuffer<CR>
noremap <m-p> <esc>:NifflerMRU<CR>
noremap <c-p> <esc>:Niffler -vcs<CR>
noremap <Leader>z <esc>:YcmCompleter GoToDeclaration<CR>
let g:niffler_ignore_extensions = [".gcno*", ".gcda*", ".o", "*.html"]

" Editing init.vim
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" expand current file path
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" allow hidden buffers
set hidden

" copy current file
nnoremap <Leader>ks :let @+=expand("%")<CR>
nnoremap <Leader>kl :let @+=expand("%:p")<CR>

:set wildignore+=build/**,tags

" Required:
set runtimepath+=~/.nvim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'https://github.com/easymotion/vim-easymotion'
NeoBundle 'https://github.com/Valloric/YouCompleteMe'
NeoBundle 'https://github.com/eugen0329/vim-esearch'
NeoBundle 'https://github.com/scrooloose/nerdtree'
NeoBundle 'https://github.com/airblade/vim-gitgutter'
NeoBundle 'https://github.com/tpope/vim-obsession'
" NeoBundle 'https://github.com/jeetsukumaran/vim-buffergator'
NeoBundle 'https://github.com/ntpeters/vim-better-whitespace'
NeoBundle 'https://github.com/terryma/vim-multiple-cursors'
NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'https://github.com/SirVer/ultisnips'
NeoBundle 'https://github.com/honza/vim-snippets'
NeoBundle 'https://github.com/brookhong/cscope.vim'
NeoBundle 'https://github.com/pgdouyon/vim-niffler'
NeoBundle 'https://github.com/ericcurtin/CurtineIncSw.vim'
call neobundle#end()

" Cscope
nnoremap <leader>ca :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
let g:cscope_silent = 1

" Some optional key mappings to search directly.

" s: Find this C symbol
nnoremap  <leader>cs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>cg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>cd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>cc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ct :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>ce :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>cf :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>ci :call CscopeFind('i', expand('<cword>'))<CR>


" Ultisnips

" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

autocmd VimEnter * ToggleStripWhitespaceOnSave

" Automatic reloading of .vimrc
"" autocmd! bufwritepost .vimrc source %

" Multiple cursors mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-m>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
   call youcompleteme#DisableCursorMovedAutocommands()
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    call youcompleteme#EnableCursorMovedAutocommands()
endfunction

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

let g:esearch = {
  \ 'adapter':    'ag',
  \ 'backend':    'nvim',
  \ 'out':        'qflist',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}

set pastetoggle=<F2>
set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" :set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
"" noremap <C-n> :nohl<CR>
"" vnoremap <C-n> :nohl<CR>
"" inoremap <C-n> :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h

"Jump more easily in Quick fix
nnoremap <Leader>w :cn<CR>
nnoremap <Leader>q :cp<CR>

" Surround world with "
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" ESC simulation
:inoremap jk <esc>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=119   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=120
highlight ColorColumn ctermbg=233p


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1

"Autoreload files when changed externally
set autoread
autocmd FocusGained * silent! checktime

" Go to definition in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

