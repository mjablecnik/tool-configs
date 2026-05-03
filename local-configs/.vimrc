" use advanced Vim features
set nocompatible
set clipboard=unnamed

let NERDTreeWinPos="left"

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
"set mousefocus
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
" number of screen lines to keep above and below the cursor
set scrolloff=2
set sidescrolloff=10
set sidescroll=10
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
" I want man to open in new termwin
" unfortunately doesn't work
"set keywordprg=rxvt\ -e\ man
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

nmap <F7> :diffget<CR>
nmap <F8> :diffput<CR>
nmap <F9> :diffupdate<CR>

nmap gf :sp <cfile><CR>

source $VIMRUNTIME/menu.vim
set wildmenu
"set wildmode=longest,list
set wildmode=longest,full
set wcm=<C-Z>
map <F10> :emenu <C-Z>


filetype indent on
filetype plugin on

autocmd FileType python set omnifunc=pythoncomplete#Complete

au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab



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

" DirDiff
let g:DirDiffExcludes = "CVS"




" ---- Martin hacks ---- 

map t :tabedit<space>
map <c-n> gt
map <c-p> gT

map gn :bn<CR>
map gp :bp<CR>

noremap <S-w><S-w> :w <CR>
map <S-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.retry$']
"map <C-r> :r !bash ~/.tmux/run_puppet.sh<CR>
set nopaste
set tabstop=2

set foldmethod=indent
set foldlevel=99
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>

"map < <C-w><
"map > <C-w>>
map - <C-w>-
map + <C-w>+
map <space> <space>


au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:snips_trigger_key = '<tab>'
let g:snips_trigger_key_backwards = '<s-tab>'

" MiniBufExpl Colors
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

"set ffs=dos

noremap ]] k[mj
noremap [[ ]mj

"map <M-s>
map <leader>w :%s/\s\+$//e<CR>:w<CR>
vmap <esc> v

imap jj <Esc>
imap kk <Esc>

"imap ll <Esc>la
"imap hh <Esc>ha
imap <C-c> <CR><Esc>O
nmap <C-c> di}i<CR><Esc>O<Esc>p
"wmap :W :w




""" Gitgutter customiation 
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>u <Plug>GitGutterRevertHunk
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn ctermbg=whatever    " terminal Vim
"highlight SignColumn guibg=white      " gVim/MacVim
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = 'w'
"let g:gitgutter_highlight_lines = 1

highlight GitGutterAddLine guibg=green 
highlight GitGutterChangeLine guibg=orange 
highlight GitGutterDeleteLine guibg=red 
highlight GitGutterAddLine ctermbg=green 
highlight GitGutterChangeLine ctermbg=blue 
highlight GitGutterDeleteLine ctermbg=red 
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <leader>h :GitGutterLineHighlightsToggle<CR>
nmap <leader>ht :GitGutterToggle<CR>








if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

let g:session_autosave = 'no'
let g:session_autoload = 'no'
"execute pathogen#infect()
"call pathogen#helptags()



au BufReadPost *.ts set syntax=typescript



