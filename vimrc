" No, no, no!
set noexrc

" Base
set nocompatible " turn off vi-compatible mode

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'fatih/vim-go'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'altercation/vim-colors-solarized'

if has("lua")
    Plugin 'Shougo/neocomplete.vim'
endif

call vundle#end()

filetype plugin indent on
syntax on

" Encoding
set encoding=utf-8 nobomb
set fileencoding=utf-8

" File
set fileformats=unix,dos,mac
set fileformat=unix
set autoread " load changes made from outside
set nomodeline " seriously modelines?

" History
set directory=~/.tmp/vim/swaps
set backupdir=~/.tmp/vim/backup

if has("persistent_undo")
    set undodir=~/.tmp/vim/undo
    set undofile
endif

set undolevels=1000
set history=100
set backup
set viminfo='100,<1000,/1000,c,n~/.tmp/vim/viminfo

" Interface
set showmode " current mode (insert, visual, etc)
set showcmd
set title
set nofoldenable
set number
set numberwidth=4
set cmdheight=1
set laststatus=2 " always show statusline
set scrolloff=5
set sidescrolloff=5 " number of horizontal lines visible around cursor
set showmatch
set matchtime=2 " matching brackets cursor blink time (1/10 * n)
set hidden " hide unsaved buffer
set splitbelow
set splitright
set lazyredraw " do not redraw during macros
set linespace=0
set statusline=%<\%f\ [%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y\ %l/%L:%c
"               |  |    |  | | | |          |                        |       |   |  |  |
"               |  |    |  | | | |          +-- encoding             |       |   |  |  +-- column
"               |  |    |  | | | +------------- preview              |       |   |  +----- total lines
"               |  |    |  | | +--------------- help                 |       |   +-------- line
"               |  |    |  | +----------------- readonly             |       +------------ filetype
"               |  |    |  +------------------- modfied              +-------------------- format
"               |  |    +---------------------- buffer
"               |  +--------------------------- filepath
"               +------------------------------ truncate from left
set shortmess=aIOT
"             ||||
"             |||+-- truncate message in the middle
"             ||+--- no message on file changes (autoread)
"             |+---- no startup message
"             +----- use abbreviations

" Diff
set diffopt=filler,vertical


" Completion
set infercase
set omnifunc=syntaxcomplete#Complete
set complete+=kspell
"               |
"               +-- add spell dictionary
set completeopt=menuone
"                  |
"                  +-- show popup menu if there's only one item

" Search
set ignorecase
set smartcase
set hlsearch " highlight search
set incsearch " highlight search string while typing
set magic " use backslashes for magic characters
set wrapscan

" Editing
set gdefault " substitute globally by default
set whichwrap+=h,l " vi keys wrap around lines
set backspace=eol,start,indent " backspace across lines
set textwidth=0 " no auto-wrapping
set tabstop=8 " number of spaces a tab counts for
set softtabstop=4 " number of spaces while indenting
set shiftwidth=4 " number of spaces while shifting
set expandtab " use spaces rather than tabs
set smarttab " handle spaces like tabs while deleting them
set shiftround " round to a multiple of shiftwidth while indenting
set nowrap " don't wrap lines
set autoindent " auto indent next line
set copyindent " use the same indentation for autoindent
set nostartofline " cursor stays at same column while moving horizontal
set nolist " don't show invisble character
set nospell " no spellcheck
set noeol " do not add empty newlines at end of file
set clipboard=unnamed " use os clipboard
set listchars=tab:▸\ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:« " invisible character
set formatoptions=qn
"                 ||
"                 |+--- recognize numbered lists
"                 +---- allow formatting comments

" Timing
set updatetime=1000
set notimeout
set ttimeout
set ttimeoutlen=500
set ttyfast " optimize for fast terminal connections
set t_ut= " no background redraw

" Sync
set synmaxcol=400
syn sync minlines=200
syn sync maxlines=500

" Mouse
if has("mouse")
    set ttymouse=xterm2 " modern mouse
    set mousehide " hide mouse pointer
    set mouse=nvc " enable mouse in:
"             |||
"             ||+-- commandline mode
"             |+--- visual mode
"             +---- normal mode
endif

" Color
try
    set background=dark
    let g:solarized_visibility="high"
    colorscheme solarized
catch
endtry

" Fileglob
set wildmenu " enable filepath completion in the command bar
set wildmode=longest:full
set wildchar=<Tab>
set wildignore+=*~,*sw[op],*.pid,.DS_Store
set wildignore+=.git,.hg,.svn
set wildignore+=*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib
set wildignore+=*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso
set wildignore+=*.pdf,*.doc*,*.aux,*.out,*.toc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.psd,*.ai,*.ico
set wildignore+=*.db,*.sqlite

" Leader
let mapleader = "," " `\` no thank you

" Keymap
map <silent> <leader>q :qa<cr>
map <silent> <leader>c :close<cr>
map <silent> <leader>C :bd<cr>
map <silent> <leader>w :w<cr>
map <leader>W :w !sudo tee %<cr>

noremap <silent> <leader><space> :noh<cr>
noremap <silent> <leader>i :set list!<cr>

nnoremap Y y$
noremap j gj
noremap k gk
nnoremap J :m .+1<cr>
nnoremap K :m .-2<cr>
vnoremap J :m '>+1'<cr>gv=gv
vnoremap K :m '<-2'<cr>gv=gv

noremap <C-e> 5<C-e>
noremap <C-y> 5<C-y>
noremap <C-J> 5gj
noremap <C-K> 5gk

noremap <silent> H :bp<cr>
noremap <silent> L :bn<cr>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

nnoremap / /\v
vnoremap / /\v

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Trigger: Remember cursor position
autocmd BufReadPost *\(.git/COMMIT_EDITMSG\)\@<! if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Custom: Filetype
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
autocmd BufNewFile,BufRead *.go setlocal filetype=go
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd BufNewFile,BufRead *.cls,*.sty setlocal filetype=tex
autocmd BufNewFile,BufRead *.frag,*.vert,*.shader,*.glsl setlocal filetype=glsl
autocmd BufNewFile,BufRead gitconfig setlocal filetype=gitconfig

" Custom: Indent
autocmd FileType make,go,glsl,c,cpp setlocal softtabstop=8 shiftwidth=8 noexpandtab

" Custom: Spelling
autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en

" Custom: Textwidth
autocmd FileType text setlocal textwidth=80
autocmd FileType gitcommit setlocal textwidth=72

" Custom: Colorcolumn
if exists('+colorcolumn')
    autocmd FileType python setlocal colorcolumn=81
    autocmd FileType text setlocal colorcolumn=+1
    autocmd FileType gitcommit setlocal colorcolumn=51,73
endif

" Plugin: Gitgutter
let g:gitgutter_sign_column_always = 1
hi! link SignColumn LineNr

" Plugin: Vim-Go
let g:go_fmt_command = "goimports"
let g:go_doc_keywordprg_enabled = 0

" Plugin: NeoComplete
if has("lua")
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#max_list = 20
    let g:neocomplete#max_keyword_width = 80
    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#enable_ignore_case = 1
    inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr><Esc> pumvisible() ? neocomplete#cancel_popup() : "\<Esc>"
    inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
endif
