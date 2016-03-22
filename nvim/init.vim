" No, no, no!
set noexrc
set shell=/bin/sh

let g:python3_host_prog='/usr/local/bin/python3'
let g:python3_host_skip_check=1

" Install vimplug
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
    silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall! | qall
endif

call plug#begin()

" Plugins:
Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/sideways.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'ap/vim-buftabline'
Plug 'benekastah/neomake'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/gv.vim',                     { 'on': 'GV' }
Plug 'junegunn/vim-easy-align',             { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'mbbill/undotree',                     { 'on': 'UndotreeToggle' }
Plug 'moll/vim-bbye',                       { 'on': 'Bdelete' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'rking/ag.vim',                        { 'on': 'Ag' }
Plug 'shougo/deoplete.nvim'
Plug 'shougo/neosnippet.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-troll-stopper'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-gotham'

" Filetype:
Plug 'cespare/vim-toml',                    { 'for': 'toml' }
Plug 'dag/vim-fish',                        { 'for': 'fish' }
Plug 'ekalinin/Dockerfile.vim',             { 'for': 'dockerfile' }
Plug 'fatih/vim-go',                        { 'for': 'go' }
Plug 'ingydotnet/yaml-vim',                 { 'for': 'yaml' }
Plug 'klen/python-mode',                    { 'for': 'python' }
Plug 'lervag/vimtex',                       { 'for': 'tex' }
Plug 'rust-lang/rust.vim',                  { 'for': 'rust' }
Plug 'yosssi/vim-ace',                      { 'for': 'ace' }
Plug 'zchee/deoplete-clang',                { 'for': ['c', 'cpp'] }
Plug 'zchee/deoplete-go',                   { 'for': 'go', 'do': 'make' }

call plug#end()

" Encoding
set nobomb

" File
set fileformats=unix,dos,mac
set autoread " load changes made from outside
set nomodeline " seriously modelines?

" State
set noswapfile
set backup
set backupdir=$XDG_DATA_HOME/nvim/backup
set undofile
set undolevels=500
set undodir=$XDG_DATA_HOME/nvim/undo
set shada='100,<500,/50,:100,@100,s10,h,c,n$XDG_DATA_HOME/nvim/shada

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
" set statusline=%<\%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y\ %L\|%l:%c
"               |  |   | | | |            |                      |       |   |   |  |
"               |  |   | | | |            +-- encoding           |       |   |   |  +-- column
"               |  |   | | | +--------------- preview            |       |   |   +----- line
"               |  |   | | +----------------- help               |       |   +-------- total lines
"               |  |   | +------------------- readonly           |       +------------ filetype
"               |  |   +--------------------- modiied            +-------------------- format
"               |  +------------------------- filepath
"               +---------------------------- truncate from left
set noerrorbells
set novisualbell
set shortmess=aIOTF
"             |||||
"             ||||+-- hide file read messages
"             |||+--- truncate message in the middle
"             ||+---- no message on file changes (autoread)
"             |+----- no startup message
"             +------ use abbreviations
set conceallevel=2
set concealcursor=niv

" Diff
set diffopt=filler,vertical
"              |      |
"              |      +-- open diff in vertical mode
"              +--------- show filler lines

" Completion
set infercase
set complete+=kspell
"               |
"               +-- add spell dictionary
set completeopt=menuone,noselect,noinsert
"                  |       |        |
"                  |       |        +-- do not insert any text
"                  |       +----------- do not select a match
"                  +------------------- always show menu if there's a match

" Search
set ignorecase
set smartcase
set hlsearch " highlight search
set incsearch " highlight search string while typing
set magic " use backslashes for magic characters
set wrapscan

" Editing
set gdefault " substitute globally by default
set backspace=indent,start " backspace over indentation and insert position
set virtualedit=block " use block selection in visual mode instead of longest column
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
set smartindent " do smart autoindenting when starting a new line
set nostartofline " cursor stays at same column while moving horizontal
set nojoinspaces " do not add additional spaces on join
set nolist " don't show invisble character
set nospell " no spellcheck
set spellfile=$XDG_CONFIG_HOME/nvim/spell/spellfile.utf-8.add
set spelllang=en
set clipboard=unnamed " use os clipboard
set listchars=tab:▸\ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:« " invisible character
set formatoptions=qcnr
"                 ||||
"                 ||||
"                 |||+--- insert comment leader after enter
"                 ||+---- recognize numbered lists
"                 |+----- auto-wrap comments using textwidth
"                 +------ allow formatting comments

" Sync
set synmaxcol=200
syn sync minlines=200
syn sync maxlines=500

" Mouse
set mousehide " hide mouse pointer
set mouse=nvc " enable mouse in:
"         |||
"         ||+-- commandline mode
"         |+--- visual mode
"         +---- normal mode

" Color
try
    colorscheme gotham
catch
endtry

" Fileglob
set wildmenu " enable filepath completion in the command bar
set wildmode=longest:full,list:longest
set wildchar=<tab>
set wildignore+=*~,*sw[op],*.pid,.DS_Store
set wildignore+=.git,.hg,.svn
set wildignore+=*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib
set wildignore+=*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso
set wildignore+=*.pdf,*.doc*,*.aux,*.out,*.toc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.psd,*.ai,*.ico
set wildignore+=*.db,*.sqlite

" Disable buildin plugins
let g:loaded_2html_plugin=1
let g:loaded_getscript=1
let g:loaded_getscriptPlugin=1
let g:loaded_gzip=1
let g:loaded_netrw=1
let g:loaded_netrwFileHandlers=1
let g:loaded_netrwPlugin=1
let g:loaded_netrwSettings=1
let g:loaded_rrhelper=1
let g:loaded_tar=1
let g:loaded_tarPlugin=1
let g:loaded_tutor_mode_plugin=1
let g:loaded_vimball=1
let g:loaded_vimballPlugin=1
let g:loaded_zip=1
let g:loaded_zipPlugin=1

" Leader
let mapleader="," " `\` no thank you

" Keymap
map <leader>q :quitall<cr>
map <leader>w :write<cr>
map <leader>x :exit<cr>
map <leader>c :quit<cr>
map <leader>W :write !sudo tee %<cr>
map <leader>f :echo expand("%:p")<cr>

noremap <leader><esc> :nohlsearch<cr>
noremap <leader>i :setlocal list!<cr>
noremap <leader>s :setlocal spell!<cr>

noremap <c-h> :bprev<cr>
noremap <c-l> :bnext<cr>

nnoremap Y y$
nnoremap <c-j> :move .+1<cr>
nnoremap <c-k> :move .-2<cr>
vnoremap <c-j> :move '>+1'<cr>gv=gv
vnoremap <c-k> :move '<-2'<cr>gv=gv

nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Trigger: Title
autocmd BufEnter,VimEnter * let &titlestring=expand("%:t")
autocmd VimLeave * let &titlestring=''

" Trigger: Autoread
autocmd BufEnter * :silent checktime

" Trigger: Remember cursor position
autocmd BufReadPost * if &filetype != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Trigger: Switch between relative/norelative numbers in insert mode
autocmd InsertEnter,WinLeave,FocusLost * setlocal norelativenumber
autocmd InsertLeave,WinEnter,FocusGained * setlocal relativenumber

" Trigger: Cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Custom: Filetype
autocmd BufNewFile,BufRead *.cls,*.sty setlocal filetype=tex
autocmd BufNewFile,BufRead *.frag,*.vert,*.shader,*.glsl setlocal filetype=glsl
autocmd BufNewFile,BufRead gitconfig setlocal filetype=gitconfig

" Custom: Indent
autocmd FileType c,cpp setlocal cindent
autocmd FileType make,go,glsl,c,cpp,neosnippet setlocal softtabstop=8 tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType yaml,toml,json,ruby,javascript setlocal softtabstop=2 shiftwidth=2

" Custom: Spelling
autocmd FileType markdown,gitcommit setlocal spell
autocmd FileType gitcommit setlocal spelllang=en

" Custom: Textwidth
autocmd FileType gitcommit setlocal textwidth=72 wrap
autocmd FileType text,markdown setlocal textwidth=80 wrap

" Custom: Colorcolumn
autocmd FileType python,c,cpp setlocal colorcolumn=81
autocmd FileType text,markdown setlocal colorcolumn=+1
autocmd FileType gitcommit setlocal colorcolumn=51,+1

" Colors: Spelling Errors
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=1

" Markdown:
let g:markdown_fenced_languages=[
    \ 'bash=sh',
    \ 'conf',
    \ 'make',
    \ ]

" Plugin: neomake
noremap <leader><space> :Neomake!<cr>
let g:neomake_serialize=1
let g:neomake_warning_sign={
    \ 'text': '!',
    \ 'texthl': 'WarningMsg',
    \ }
let g:neomake_error_sign={
    \ 'text': '>',
    \ 'texthl': 'ErrorMsg',
    \ }

" Plugin: fzf
noremap <c-p> :FZF<cr>
noremap <leader>b :FZFBuffer<cr>
noremap <leader>o :FZFMru<cr>
let g:fzf_launcher='xterm -e fish -ic %s'

function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! FZFBuffer call fzf#run({
    \ 'source': reverse(<sid>buflist()),
    \ 'sink': function('<sid>bufopen'),
    \ 'options': '+m',
    \ 'down': len(<sid>buflist()) + 2
    \ })

command! FZFMru call fzf#run({
    \ 'source': v:oldfiles,
    \ 'sink': 'e ',
    \ 'options': '+m',
    \ 'down': len(v:oldfiles) + 2
    \ })

" Plugin: ag.vim
let g:ag_prg="ag --vimgrep --smart-case"
let g:ag_mapping_message=0

" Plugin: rainbow
let g:rainbow_active=0

" Plugin: vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<leader>m'
let g:multi_cursor_next_key='<c-n>'
let g:multi_cursor_prev_key='<c-p>'
let g:multi_cursor_skip_key='<c-x>'
let g:multi_cursor_quit_key='<esc>'

" Plugin: vim-gitgutter
let g:gitgutter_override_sign_column_highlight=0
let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1
let g:gitgutter_eager=1
let g:gitgutter_map_keys=0
nmap gn <plug>GitGutterNextHunk
nmap gp <plug>GitGutterPrevHunk

" Plugin: vim-bbye
nnoremap <leader>d :Bdelete<CR>

" Plugin: python-mode
let g:pymode_rope=0

" Plugin: vim-go
let g:go_fmt_command="goimports"
let g:go_fmt_fail_silently=1
let g:go_doc_keywordprg_enabled=1

" Plugin: vim-better-whitespace
noremap <leader>I :ToggleWhitespace<cr>

" Plugin: auto-pairs
let g:AutoPairsMapCR=0 " no funny stuff on carriage return
if exists('g:AutoPairs')
    autocmd filetype markdown let b:AutoPairs=extend(copy(g:AutoPairs), {"$":"$"})
endif

" Plugin: vim-easy-align
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" Plugin: undotree
nnoremap <leader>u :UndotreeToggle<cr>

" Plugin: sideways.vim
nnoremap gh :SidewaysLeft<cr>
nnoremap gl :SidewaysRight<cr>

" Plugin: vim-buftabline
let g:buftabline_show=1
let g:buftabline_indicators=1

" Plugin: lightline.vim
let g:lightline={
    \ 'colorscheme': 'gotham',
    \ 'mode_map': {
    \     'n': 'normal',
    \     'i': 'insert',
    \     'R': 'replace',
    \     'v': 'visual',
    \     'V': 'v-line',
    \     'c': 'command',
    \     "\<C-v>": 'v-block',
    \     's': 'select',
    \     'S': 's-line',
    \     "\<C-s>": 's-block',
    \     '?': '      '
    \ },
    \ 'active': {
    \     'left': [
    \         ['mode'],
    \         ['filename'],
    \         ['fugitive', 'modified', 'readonly']
    \     ],
    \     'right': [
    \         ['lineinfo'],
    \         ['percent'],
    \         ['filetype', 'fileformat', 'fileencoding']
    \     ]
    \ },
    \ 'inactive': {
    \     'left': [
    \         ['filename']
    \     ],
    \     'right': [
    \         ['percent']
    \     ]
    \ },
    \ 'component_function': {
    \     'fugitive': 'LightLineFugitive',
    \ },
    \ }

function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

" Plugin: neosnippet.vim
let g:neosnippet#disable_runtime_snippets={ '_' : 1, }
let g:neosnippet#snippets_directory=$XDG_CONFIG_HOME."/nvim/snippets"
let g:neosnippet#enable_snipmate_compatibility=1
autocmd InsertLeave * NeoSnippetClearMarkers

" Plugin: deocomplete.nvim
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_completion_start_length=1
let g:deoplete#enable_camel_case=1
let g:deoplete#max_list=100
let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#clang#libclang_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang'
let g:deoplete#sources#clang#std#c='c11'
let g:deoplete#sources#clang#std#cpp='c++11'
smap <silent><expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_jump)" : "\<tab>"
imap <silent><expr><tab> pumvisible() ? "\<c-n>" : neosnippet#jumpable() ? "\<plug>(neosnippet_jump)" : "\<tab>"
imap <silent><expr><cr> !pumvisible() ? "\<cr>\<plug>AutoPairsReturn" : neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : deoplete#mappings#close_popup()
imap <silent><expr><esc> pumvisible() ? deoplete#mappings#close_popup() : "\<esc>"
imap <silent><expr><bs>  deoplete#mappings#smart_close_popup()."\<bs>"

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
