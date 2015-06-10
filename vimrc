" No, no, no!
set noexrc
set shell=/bin/sh

" Base
set nocompatible " turn off vi-compatible mode

" Plugins
call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'rking/ag.vim',            { 'on': 'Ag' }
Plug 'tpope/vim-abolish',       { 'on': ['Abolish', 'Subvert'] }
Plug 'fatih/vim-go',            { 'for': 'go' }
Plug 'dag/vim2hs',              { 'for': 'haskell' }
Plug 'dag/vim-fish',            { 'for': 'fish' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'cespare/vim-toml',        { 'for': 'toml' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
if has("lua")
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/neosnippet.vim'
endif

call plug#end()

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

set undolevels=500
set backup
set viminfo='10,<500,/50,:100,@100,s10,h,c,n~/.tmp/vim/viminfo

" Interface
set showmode " current mode (insert, visual, etc)
set showcmd
set title
set nofoldenable
set number
set relativenumber
set cursorline
set numberwidth=3
set cmdheight=1
set laststatus=2 " always show statusline
set scrolloff=3
set sidescrolloff=5 " number of horizontal columns visible around cursor
set showmatch
set matchtime=2 " matching brackets cursor blink time (1/10 * n)
set hidden " hide unsaved buffer
set splitbelow
set splitright
set lazyredraw " do not redraw during macros
set linespace=0
set statusline=%<\%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y\ %l/%L:%c
"               |  |   | | | |            |                      |       |   |  |  |
"               |  |   | | | |            +-- encoding           |       |   |  |  +-- column
"               |  |   | | | +--------------- preview            |       |   |  +----- total lines
"               |  |   | | +----------------- help               |       |   +-------- line
"               |  |   | +------------------- readonly           |       +------------ filetype
"               |  |   +--------------------- modiied            +-------------------- format
"               |  +------------------------- filepath
"               +---------------------------- truncate from left
set shortmess=aIOT
"             ||||
"             |||+-- truncate message in the middle
"             ||+--- no message on file changes (autoread)
"             |+---- no startup message
"             +----- use abbreviations

" Diff
set diffopt=filler,vertical
"              |      |
"              |      +-- open diff in vertical mode
"              +--------- show filler lines


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
set virtualedit=block " use block selection in visual mode instead of longest column
set textwidth=0 " no auto-wrapping
set tabstop=8 " number of spaces a tab counts for
set softtabstop=4 " number of spaces while indenting
set shiftwidth=4 " number of spaces while shifting
set expandtab " use spaces rather than tabs
set smarttab " handle spaces like tabs while deleting them
set shiftround " round to a multiple of shiftwidth while indenting
set nowrap " don't wrap lines
set linebreak " don't break words at line end
set autoindent " auto indent next line
set copyindent " use the same indentation for autoindent
set nostartofline " cursor stays at same column while moving horizontal
set nolist " don't show invisble character
set nospell " no spellcheck
set noeol " do not add empty newlines at end of file
set clipboard=unnamed " use os clipboard
set listchars=tab:▸\ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:« " invisible character
set formatoptions=qntc
"                 ||||
"                 |||+- auto-wrap comments using textwidth
"                 ||+-- auto-wrap text using textwidth
"                 |+--- recognize numbered lists
"                 +---- allow formatting comments

" Timing
set updatetime=1000
set notimeout
set ttimeout
set ttimeoutlen=500
set ttyfast
set t_ut= " no background redraw

" Sync
set synmaxcol=400
syn sync minlines=200
syn sync maxlines=500

" Mouse
if has("mouse")
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
set wildmode=longest:full,list:longest
set wildchar=<Tab>
set wildignore+=*~,*sw[op],*.pid,.DS_Store
set wildignore+=.git,.hg,.svn
set wildignore+=*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib
set wildignore+=*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso
set wildignore+=*.pdf,*.doc*,*.aux,*.out,*.toc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.psd,*.ai,*.ico
set wildignore+=*.db,*.sqlite

" Leader
let mapleader="," " `\` no thank you

" Keymap
map <silent><leader>q :qa<cr>
map <silent><leader>c :close<cr>
map <silent><leader>C :bd<cr>
map <silent><leader>w :w<cr>
map <leader>W :w !sudo tee %<cr>

noremap <silent><leader><esc> :noh<cr>
noremap <silent><leader>i :set list!<cr>

noremap <silent><c-h> :bp<cr>
noremap <silent><c-l> :bn<cr>

nnoremap Y y$
nnoremap <c-j> :m .+1<cr>
nnoremap <c-k> :m .-2<cr>
vnoremap <c-j> :m '>+1'<cr>gv=gv
vnoremap <c-k> :m '<-2'<cr>gv=gv

nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap n nzz
nnoremap } }zz

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
autocmd BufReadPost * if &ft != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Trigger: Switch between relative/norelative numbers in insert mode
autocmd InsertEnter * setlocal norelativenumber
autocmd InsertLeave * setlocal relativenumber

" Custom: Filetype
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
autocmd BufNewFile,BufRead *.go setlocal filetype=go
autocmd BufNewFile,BufRead *.json setlocal filetype=javascript
autocmd BufNewFile,BufRead *.cls,*.sty setlocal filetype=tex
autocmd BufNewFile,BufRead *.frag,*.vert,*.shader,*.glsl setlocal filetype=glsl
autocmd BufNewFile,BufRead gitconfig setlocal filetype=gitconfig
autocmd BufNewFile,BufRead *.fish setlocal filetype=fish

" Custom: Indent
autocmd FileType make,go,glsl,c,cpp,neosnippet setlocal softtabstop=8 shiftwidth=8 noexpandtab

" Custom: Spelling
autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en

" Custom: Textwidth
autocmd FileType text,markdown setlocal textwidth=80
autocmd FileType gitcommit setlocal textwidth=72

" Custom: Colorcolumn
if exists('+colorcolumn')
    autocmd FileType python setlocal colorcolumn=81
    autocmd FileType text,markdown setlocal colorcolumn=+1
    autocmd FileType gitcommit setlocal colorcolumn=51,73
endif

" Plugin: CtrlP
let g:ctrlp_map = '<leader><space>'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_height = 20
let g:ctrlp_working_path_mode = 0
let g:ctrlp_lazy_update = 50
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup
      \ --ignore "**/*.pyc"
      \ -g ""'

" Plugin: Yankstack
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Plugin: Ag
let g:agprg="ag --column"

" Plugin: Markdown
let g:vim_markdown_frontmatter=1

" Plugin: Multiple Cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<leader>m'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-j>'
let g:multi_cursor_quit_key='<Esc>'

function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Plugin: Gitgutter
let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=0
hi! link SignColumn LineNr
nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk

" Plugin: Vim-Go
let g:go_fmt_command="goimports"
let g:go_fmt_fail_silently=1
let g:go_doc_keywordprg_enabled=1

" Plugin: Better-WhiteSpace
noremap <silent><leader>I :ToggleWhitespace<cr>

" Plugin: Auto-Pairs
let g:AutoPairsMapCR=0 " no funny stuff on carriage return

" Plugin: NeoComplete
if has("lua")
    let g:acp_enableAtStartup=0
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#max_list=15
    let g:neocomplete#max_keyword_width=50
    let g:neocomplete#min_keyword_length=4
    let g:neocomplete#auto_completion_start_length=3
    let g:neosnippet#disable_runtime_snippets={ '_' : 1, }
    let g:neosnippet#snippets_directory="~/.vim/snippets"
    let g:neosnippet#enable_snipmate_compatibility = 1
    imap <expr><tab> pumvisible() ? "\<c-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<tab>"
    smap <expr><tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<tab>"
    imap <expr><cr>  !pumvisible() ? "\<cr>" : neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : neocomplete#close_popup()
    inoremap <expr><esc> pumvisible() ? neocomplete#cancel_popup() : "\<esc>"
    inoremap <expr><bs> neocomplete#smart_close_popup()."\<bs>"
    inoremap <expr><c-g> neocomplete#undo_completion()
    inoremap <expr><c-l> neocomplete#complete_common_string()
    if has('conceal')
          set conceallevel=2 concealcursor=niv
    endif
endif
