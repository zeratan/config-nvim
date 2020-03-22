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

" Tab navigation like Firefox.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Make and cope

function! MakeAndCopeConditional(target)
    silent !make "-f Makefile.user " + a:target
    if v:shell_error
        cope
    else
        echom "Compile succeeded"
    endif
    redraw!
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" noremap <Leader>c <esc>:wa<CR> :call MakeAndCopeConditional("tests")<cr>
" noremap <Leader>d <esc>:wa<CR> :call MakeAndCopeConditional("main")<cr>
" noremap <Leader>c <esc>:wa<CR>:!cd build-test && make <CR>:cope<CR>G
" noremap <Leader>d <esc>:wa<CR>:!cd build && make <CR>:cope<CR>G
noremap <Leader>c <esc>:wa<CR>:make -f Makefile.user tests <bar> <CR>:cope<CR>gg/error:\\|warning:<CR><CR>
"Command output to Vim window.
noremap <Leader>C <esc>:Shell ./build/bin/example -f foo.txt<CR>
noremap <Leader>d <esc>:wa<CR>:make -f Makefile.user main <bar> <CR>:cope<CR>gg/error:\\|warning:<CR><CR>

"YcmCompleter
noremap <Leader>z <esc>:YcmCompleter GoToDeclaration<CR>
noremap <Leader>Z <esc>:YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <Leader>f <esc>:YcmCompleter FixIt<CR>

" Niffler
if 0
    noremap <Leader><c-p> <esc>:NifflerBuffer<CR>
    noremap <Leader><c-o> <esc>:NifflerMRU<CR>
    noremap <c-p> <esc>:Niffler -vcs<CR>
    let g:niffler_ignore_extensions = [".gcno*", ".gcda*", ".o", "*.html"]
    let g:niffler_ignore_dirs = ["./build/*"]
endif

" Unite
:nnoremap <C-p> [unite]p

" Editing init.vim
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" expand current file path
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" allow hidden buffers
set hidden

" Copy file name to clipboard
nnoremap <Leader>ks :let @+=expand("%")<CR>
" copy current file path to clipboard
nnoremap <Leader>kl :let @+=expand("%:p")<CR>

:set wildignore+=build/**,tags

" Make case-sensitive
:set noic

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
" Disable because doesn't search deep enough
NeoBundle 'https://github.com/eugen0329/vim-esearch'
NeoBundle 'https://github.com/mileszs/ack.vim'
NeoBundle 'https://github.com/scrooloose/nerdtree'
" Disable because it starts to raise errors
" NeoBundle 'https://github.com/airblade/vim-gitgutter'
NeoBundle 'https://github.com/tpope/vim-obsession'
" NeoBundle 'https://github.com/jeetsukumaran/vim-buffergator'
NeoBundle 'https://github.com/ntpeters/vim-better-whitespace'
NeoBundle 'https://github.com/terryma/vim-multiple-cursors'
NeoBundle 'https://github.com/mhinz/vim-signify'
NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'https://github.com/SirVer/ultisnips'
NeoBundle 'https://github.com/honza/vim-snippets'
NeoBundle 'https://github.com/brookhong/cscope.vim'
" NeoBundle 'https://github.com/pgdouyon/vim-niffler'
NeoBundle 'https://github.com/Shougo/vimproc.vim'
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/rstacruz/vim-fastunite'
" watch out for ignore paths in ~/.nvim/bundle/neomru.vim/autoload/neomru.vim
" e.g. /mnt/...
NeoBundle 'https://github.com/Shougo/neomru.vim'
NeoBundle 'https://github.com/Shougo/unite-outline'
NeoBundle 'https://github.com/tsukkee/unite-tag'
NeoBundle 'https://github.com/ericcurtin/CurtineIncSw.vim'
NeoBundle 'https://github.com/mileszs/ack.vim'
" Slows down. Interferes with key configuration
" NeoBundle 'https://github.com/vim-scripts/Conque-GDB'
NeoBundle 'https://github.com/idanarye/vim-vebugger'
" Use :Rename <new file name>
NeoBundle 'https://github.com/vim-scripts/Rename'
NeoBundle 'https://github.com/vim-scripts/AnsiEsc.vim'
NeoBundle 'https://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/jremmen/vim-ripgrep'
" Javascript:
NeoBundle 'https://github.com/pangloss/vim-javascript'
NeoBundle 'https://github.com/ternjs/tern_for_vim'

NeoBundle 'https://github.com/martinda/Jenkinsfile-vim-syntax'
":'<,'>B sort see http://vim.wikia.com/wiki/How_to_sort_using_visual_blocks
NeoBundle 'https://github.com/vim-scripts/vis'
NeoBundle 'https://github.com/vim-scripts/Vimball'
NeoBundle 'https://github.com/triglav/vim-visual-increment'
NeoBundle 'https://github.com/peitalin/vim-jsx-typescript'

" Causes window corruption?
" mm - Add / Remove bookmark
" mn - Next bookmark
" mp - Previous bookmark
NeoBundle 'https://github.com/MattesGroeger/vim-bookmarks'
NeoBundle 'https://github.com/vim-syntastic/syntastic'
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

set pastetoggle=<F2>
set clipboard=unnamed

" esearch settings
let g:esearch = {
  \ 'adapter':    'rg',
  \ 'backend':    'nvim',
  \ 'out':        'qflist',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}

fu! EsearchInFiles(argv) abort
  let original = g:esearch#adapter#ag#options
  let g:esearch#adapter#rg#options = input('Search options: ')
  call esearch#init(a:argv)
  let g:esearch#adapter#ag#options = original
endfu

" replace these mapping with the ones you prefer
noremap  <silent><leader>ft :<C-u>call EsearchInFiles({})<CR>
xnoremap <silent><leader>ft :<C-u>call EsearchInFiles({'visualmode': 1})<CR>

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

" Map cuda files to c++ so that Ycm can parse
autocmd BufNewFile,BufRead *.cu set filetype=cpp

"Autoreload files when changed externally
set autoread
autocmd FocusGained * silent! checktime

" Go to definition in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

function! Formatonsave()
  let l:formatdiff = 1
  if g:format_on_save > 0
    pyf /usr/lib/llvm/8/share/clang/clang-format.py
  endif
endfunction

autocmd BufWritePre *.h,*.c,*.cc,*.cpp call Formatonsave()

" Find file in current directory and edit it.
function! Find(name)
  let l:list=system("find -L . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
" replace above line with below one for gvim on windows
" let l:list=system("find . -name ".a:name." | perl -ne \"print qq{$.\\t$_}\"")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <Leader>j :call GotoJump()<CR>

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"Makes f and t work across multiple lines
nmap <silent> f :call FindChar(0, 0, 0)<cr>
omap <silent> f :call FindChar(0, 1, 0)<cr>
nmap <silent> F :call FindChar(1, 0, 0)<cr>
omap <silent> F :call FindChar(1, 1, 0)<cr>
nmap <silent> t :call FindChar(0, 0, 1)<cr>
omap <silent> t :call FindChar(0, 0, 0)<cr>
nmap <silent> T :call FindChar(1, 0, 1)<cr>
omap <silent> T :call FindChar(1, 0, 0)<cr>

"Functions
fun! FindChar(back, inclusive, exclusive)
  let flag = 'W'
  if a:back
    let flag = 'Wb'
  endif
  if search('\V' . nr2char(getchar()), flag)
    if a:inclusive
      norm! l
    endif
    if a:exclusive
      norm! h
    endif
  endif
endfun

function! OpenCurrentAsNewTab()
    let l:currentPos = getcurpos()
    tabedit %
    call setpos(".", l:currentPos)
endfunction
nmap t% :call OpenCurrentAsNewTab()<CR>

" RipGrep
let g:ackprg = 'ag --vimgrep --smart-case --glob "!perf_study/*"'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:format_on_save = 1

" https://stackoverflow.com/questions/6593299/change-from-insert-to-normal-mode-when-switching-to-another-tab
au BufLeave * call ModeSelectBufLeave()
au BufEnter * call ModeSelectBufEnter()

function! ModeSelectBufLeave()
    let b:mode_select_mode = mode()
    " A more complex addition you could make: if mode() == v, V, <C-V>, s, S, or <C-S>, store the selection and restore it in ModeSelectBufEnter
endfunction

function! ModeSelectBufEnter()
    let l:mode = mode()
    stopinsert  " First, go into normal mode
    if (l:mode == "i" || l:mode == "R" || l:mode == "Rv") &&
    \       (!exists('b:mode_select_mode') ||
    \       b:mode_select_mode == "n" ||
    \       b:mode_select_mode == "v" ||
    \       b:mode_select_mode == "V" ||
    \       b:mode_select_mode == "\<C-V>" ||
    \       b:mode_select_mode == "s" ||
    \       b:mode_select_mode == "S" ||
    \       b:mode_select_mode == "\<C-S>")
        normal l
        " Compensate for the left cursor shift in stopinsert if going from an
        " insert mode to a normal mode
    endif
    if !exists('b:mode_select_mode')
        return
    elseif b:mode_select_mode == "i"
        startinsert
    elseif b:mode_select_mode == "R"
        startreplace
    elseif b:mode_select_mode == "Rv"
        startgreplace
    endif
endfunction

