" use advanced Vim features

"set rtp+=~/.vim/

set nocompatible
set clipboard=unnamed

" expand tabs to spaces
" to insert a real tab, use CTRL-V<Tab>
set expandtab

" number of spaces to use for each step of (auto)indent
set shiftwidth=4

" number of spaces that a <Tab> in the file counts for
set tabstop=4
set softtabstop=4

" Round indent to multiple of 'shiftwidth'. Applies to > and < commands
set noshiftround

" Copy indent from current line when starting a new line
set autoindent

" vertical cursor movement keeps cursor in the same column (if possible)
set nostartofline

" When there is a previous search pattern, highlight all its matches
set hlsearch

" While typing a search pattern, show where the so far typed pattern
" matches
set incsearch

" Searches wrap around the end of the file
set wrapscan

" case of normal letters is ignored
set ignorecase

" Override 'ignorecase on' if search pattern contains uppercase characters
set smartcase

" Do not wrap lines longer than the width of the window
set nowrap

" screen won't be redrawn while executing macros, registers and other
" commands
set lazyredraw

"  precede each line with its line number
set number
" do not unload |abandon|ed buffers
set hidden
" The window that the mouse pointer is on is automatically activated
set mousefocus
set winminheight=0
" the mouse pointer is hidden when characters are typed
set mousehide
" RMB pops up a menu. Shift-LMB extends a selection.
set mousemodel=popup
" Use same directory as with last file browser
set browsedir=last
" display what mode I'm in
set showmode
" display status line for a single window too
set laststatus=2
" show the line and column number of the cursor position in the status line
set ruler
" show the ugly ^M
set fileformats=unix

set listchars=tab:>-,eol:$,trail:*,extends:>,precedes:<

set background=dark

set cinkeys-=0#
function! Ft()
    return &filetype
endfunction
function! Ro()
    if &readonly
        return 'R'
    else
        return ' '
    endif
endfunction
function! Mo()
    if &modified
        return 'M'
    else
        return ' '
    endif
endfunction
function! Nm()
    if &modifiable
        return ' '
    else
        return 'N'
    endif
endfunction
set statusline=%3n\ %<%f%=%4b/0x%02B\ %{Ft()}\ %{Mo()}%{Nm()}%{Ro()}\ %2c\ %2v\ %4l\ %4L\ %3p%%
" C
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert
set backspace=indent,eol,start
" listings pause when the whole screen is filled
set more
" Display an incomplete command in the lower right corner of the Vim window
set showcmd
" Cursor can be positioned where there is no actual character
" block   Allow virtual editing in Visual block mode.
" insert  Allow virtual editing in Insert mode.
" all     Allow virtual editing in all modes.
set virtualedit=all
" allow movement across newline in all modes, from right to left only
set whichwrap=b,h,<,[
" the following 3-fold combo makes vim react faster to <Esc> (leaving
" Visual, Command modes, etc.) this could screw cursor keys in Insert mode
" on veeeeeery slow machines / connections (not likely to ever happen)
" the default value is 1000 ms, which is terribly slow
set notimeout       " don't timeout on mappings
set ttimeout        " do timeout on terminal key codes
set timeoutlen=50   " timemout in 50 msec
" jump to the matching paren for .5sec, or beep if there isn't one
set showmatch

" Tells when the 'equalalways' option applies:
" ver     vertically, width of windows is not affected
" hor     horizontally, height of windows is not affected
" both    width and height of windows is affected
set eadirection=hor
" When on, splitting a window will put the new window below the current
" one.
set splitbelow
" When on, splitting a window will put the new window right of the current
" one.
set splitright

set shell=/bin/sh

set switchbuf=useopen,split

" abort prompts on ^G
cmap <c-g> <c-c>
" <Space> in Normal mode scrolls down one screenful (like a pager)
nmap <Space> <C-F>
" after performing a search, matches are highlighted. get rid of the
" highlighting with <Enter>
" breaks e. g. quickfix window! (:.cc still works)
nnoremap <silent> <Enter> :nohl<Enter>
inoremap <C-F> <C-X><C-F>


filetype indent on
filetype plugin on


" settings for GUI
if has("gui_running")
    colorscheme murphy
    set winaltkeys=menu
    set guifont=-misc-fixed-medium-r-semicondensed-*-*-120-*-*-c-*-iso8859-2
endif
if &t_Co > 2 || has("gui_running")
    syntax on
    highlight Folded guifg=Wheat guibg=DarkRed
    syntax sync fromstart
endif

" no friggin' toolbar
set guioptions-=T



" set syntaxes
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
au! BufNewFile,BufReadPost *.ts set syntax=typescript
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType vue setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType svelte setlocal ts=2 sts=2 sw=2 expandtab




" ---- Martin hacks ---- 

map t :tabedit<space>
map <c-n> gt
map <c-p> gT

map gn :bn<CR>
map gp :bp<CR>

map <S-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.retry$']
set nopaste
set tabstop=2

set foldmethod=indent
set foldlevel=99
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map - <C-w>-
map + <C-w>+
map <space> <space>


"noremap ]] k[mj
"noremap [[ ]mj
imap jj <Esc>j
imap kk <Esc>k

"vmap <esc> v
"imap <C-c> <CR><Esc>O
"nmap <C-c> di}i<CR><Esc>O<Esc>p





" ---- Plugins ---- 
set rtp+=~/.local/nvim/plugins/minibufexpl.vim/
set rtp+=~/.local/nvim/plugins/vim-gitgutter/
set rtp+=~/.local/nvim/plugins/nerdtree/
set rtp+=~/.local/nvim/plugins/lightline.vim/
set rtp+=~/.local/nvim/plugins/vim-table-mode/
"set rtp+=~/.local/nvim/plugins/test/
set rtp+=~/.local/nvim/plugins/nvim-table/
set rtp+=~/.local/nvim/plugins/deoplete.nvim/
"set rtp+=~/.vim/tabnine-vim
set rtp+=~/.local/nvim/plugins/kotlin-vim/
set rtp+=~/.local/nvim/plugins/vim-go/
set rtp+=~/.local/nvim/plugins/vim-javascript/
set rtp+=~/.local/nvim/plugins/vim-vue/
set rtp+=~/.local/nvim/plugins/vim-svelte/

" call plug#begin('~/.local/nvim/plugged')
" "Plug 'posva/vim-vue'	
" "Plug 'dhruvasagar/vim-table-mode'
" "Plug 'evanleck/vim-svelte'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" call plug#end()


" NerdTree config
let NERDTreeWinPos="left"

" Deoplete config
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" MiniBufExpl config
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

let g:airline_powerline_fonts = 1
set directory-=/tmp
set directory^=/tmp//
set backupdir-=/tmp
set backupdir^=/tmp//
set guifont=monospace
colorscheme desert


""" Gitgutter customiation config 
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = 'w'
highlight GitGutterAdd    guifg=#009900 guibg=<X> ctermfg=2 
highlight GitGutterChange guifg=#bbbb00 guibg=<X> ctermfg=3 
highlight GitGutterDelete guifg=#ff2222 guibg=<X> ctermfg=1 


" vim-go config
au FileType go set noexpandtab
au FileType go set shiftwidth=2
au FileType go set softtabstop=2
au FileType go set tabstop=2

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1


""" Other configs
autocmd BufNewFile,BufRead *.kt setfiletype kotlin
autocmd BufNewFile,BufRead *.kts setfiletype kotlin

if exists('b:did_ftplugin') | finish | endif
let b:did_ftplugin = 1

setlocal comments=://
setlocal commentstring=//\ %s


