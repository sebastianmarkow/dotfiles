" No, no, no!
set noexrc

" Basics
set nocompatible " turn off vi-compatible mode
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'cohama/lexima.vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'fatih/vim-go'
Plugin 'altercation/vim-colors-solarized'

if has("lua")
    Plugin 'Shougo/neocomplete.vim'
endif

call vundle#end()

filetype plugin indent on " turn on plugins and indentation
syntax on " turn on syntax

" Encoding
scriptencoding utf-8

" Files
set fileencoding=utf-8
set fileformats=unix,dos,mac
set fileformat=unix
set autoread " reflect changes made from outside
set nomodeline " no modelines for us

" History, undo and backups
set directory=~/.tmp/vim/swaps
set backupdir=~/.tmp/vim/backup

if has("persistent_undo")
    set undodir=~/.tmp/vim/undo
    set undofile
endif

set undolevels=100
set history=100
set backup
set viminfo='100,<1000,/1000,n~/.tmp/vim/viminfo

" Interface
set showmode " show current mode (insert, visual, etc)
set showcmd " show command as you type it
set ruler " show cursor position
set title " show file title
set nofoldenable " disable folding
set number " show line numbers
set numberwidth=4 " width of number column
set cmdheight=1 " command bar height
set laststatus=2 " always show the status line
set scrolloff=5 " number of vertical lines visible around cursor
set sidescrolloff=5 " number of horizontal lines visible around cursor
set showmatch " show matching brackets if cursor is hovering over them
set matchtime=2 " matching brackets blink time (1/10 * n)
set hidden " hide unsaved buffer
set splitbelow " new horizontal split on lower screen
set splitright " new vertical split on right screen
set lazyredraw " do not redraw during macros
set linespace=0 " no extra pixels between rows
set statusline=%<\ %F%([%M%R%H]%)\ %y\ %l/%L:%c
"               |   |    | | |      |   |  |  |
"               |   |    | | |      |   |  |  +-- column number
"               |   |    | | |      |   |  +----- total number of lines
"               |   |    | | |      |   +-------- line number
"               |   |    | | |      +------------ type of file
"               |   |    | | +------------------- help buffer flag
"               |   |    | +--------------------- readonly flag
"               |   |    +----------------------- modified flag
"               |   +---------------------------- full path of file in buffer
"               +-------------------------------- truncate from the left

set complete+=kspell " add spelling to completion menu
set completeopt=menuone
"                  |
"                  +-- show popup menu if there's only one item

set shortmess=atIOTs
"             ||||||
"             |||||+-- no search hit end message
"             ||||+--- truncate message in the middle of the screen
"             |||+---- no message reading a file
"             ||+----- no intro message at startup
"             |+------ truncate message at the beginning
"             +------- use abbreviation

" Searching
set ignorecase " ignore case while searching
set infercase " case infered by default
set smartcase " if there are caps, go case-sensitive
set hlsearch " highlight search results
set incsearch " highlight search string while typing it
set magic " use backslashes for magic characters while searching

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
set shiftround " round shifts to a multiple of shiftwidth
set nowrap " don't wrap lines
set autoindent " auto indent next line
set copyindent " use the same indentation for autoindent
set nostartofline " cursor stays at same column while moving horizontal
set nolist " don't show invisble characters
set listchars=tab:▸\ ,trail:⋅,eol:¬,extends:»,precedes:«
set formatoptions=rqn
"                 |||
"                 ||+--- recognize numbered lists
"                 |+---- allow formatting comments
"                 +----- add comment leader after hitting enter

" Spellchecking
set nospell

" Timeouts
set notimeout
set ttimeout
set ttimeoutlen=500
set ttyfast
set t_ut= " no background redraw

" Mouse
if has("mouse")
    set ttymouse=xterm2 " modern mouse
    set mousehide " hide mouse pointer
    set mouse=nvc " enable mouse in
    "         |||
    "         ||+-- commandline mode
    "         |+--- visual mode
    "         +---- normal mode
endif

" Colors
try
    set background=dark
    let g:solarized_visibility="high"
    colorscheme solarized
catch
endtry

" Menu
set wildmenu " enable filepath completion in the command bar
set wildmode=longest:full
set wildignore+=*.o,*.so,*.pyc
set wildignore+=*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar
set wildignore+=*.pdf,*.epub
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.psd,*.ai
set wildignore+=*.db,*.sqlite
set wildignore+=.DS_Store

" Mapleader
let mapleader = "," " `\` no thank you

" Keys
set pastetoggle=<leader>p " unedited paste toggle
nnoremap <leader>q :qa<cr>
nnoremap <leader>c :close<cr>
nnoremap <leader>w :w<cr>
cnoremap <leader>W :w !sudo tee %<CR>
noremap <leader><space> :noh<cr>
noremap <silent> <Leader>i :set list!<CR>
noremap j gj
noremap k gk
noremap <C-J> 10gj
noremap <C-K> 10gk
noremap H :bp<cr>
noremap L :bn<cr>
nnoremap J :m .+1<cr>
nnoremap K :m .-2<cr>
vnoremap J :m '>+1'<cr>gv=gv
vnoremap K :m '<-2'<cr>gv=gv
vnoremap < <gv
vnoremap > >gv
nnoremap < <<
nnoremap > >>
nnoremap / /\v
vnoremap / /\v
nnoremap Y y$
nnoremap <silent> <C-W>s <C-W>s<C-W>j
nnoremap <silent> <C-W>v <C-W>v<C-W>l
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

" Filetypes
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
autocmd BufNewFile,BufRead *.go setlocal filetype=go
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd BufNewFile,BufRead *.cls,*.sty setlocal filetype=tex
autocmd BufNewFile,BufRead *.frag,*.vert,*.shader,*.glsl setlocal filetype=glsl
autocmd BufNewFile,BufRead gitconfig setlocal filetype=gitconfig

" Tabs
autocmd FileType make,go,glsl,c,cpp setlocal softtabstop=8 shiftwidth=8 noexpandtab

" Spell checking
autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en

" Enable colorcolumn
if exists('+colorcolumn')
    autocmd FileType python setlocal colorcolumn=80
endif

" Reset cursor to last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Trigger
autocmd InsertLeave * set nopaste " disable paste mode after leaving insert mode

" Gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_sign_column_always = 1
let g:gitgutter_realtime = 0
hi! link SignColumn LineNr

" Vim-Go
let g:go_fmt_command = "goimports"
let g:go_doc_keywordprg_enabled = 0

" NeoComplete
if has("lua")
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#max_list = 25
    let g:neocomplete#max_keyword_width = 80
    let g:neocomplete#min_keyword_length = 4
    let g:neocomplete#enable_ignore_case = 1
    inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr><Esc> pumvisible() ? neocomplete#cancel_popup() : "\<Esc>"
    inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
endif
