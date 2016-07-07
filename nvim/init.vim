scriptencoding utf-8

set noexrc " No, no, no!
set shell=/bin/sh

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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

" Setup python3 environment
let g:python3_host_prog='/usr/local/bin/python3'
let g:python3_host_skip_check=1

" Install vimplug
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
    silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup install
    autocmd!
    autocmd VimEnter * PlugInstall! | qall
    augroup END
endif

" Plugins
call plug#begin()

" Utility:
Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/sideways.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/gv.vim',                     { 'on': 'GV' }
Plug 'junegunn/vim-easy-align',             { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree',                     { 'on': 'UndotreeToggle' }
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/committia.vim'
Plug 'rking/ag.vim',                        { 'on': 'Ag' }
Plug 'shougo/deoplete.nvim'
Plug 'shougo/neosnippet.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-troll-stopper'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-gotham'

" Filetype:
Plug 'cespare/vim-toml',                    { 'for': 'toml' }
Plug 'dag/vim-fish',                        { 'for': 'fish' }
Plug 'docker/docker',                       { 'for': 'dockerfile', 'rtp': '/contrib/syntax/vim/' }
Plug 'fatih/vim-go',                        { 'for': 'go' }
Plug 'ingydotnet/yaml-vim',                 { 'for': 'yaml' }
Plug 'klen/python-mode',                    { 'for': 'python' }
Plug 'lervag/vimtex',                       { 'for': 'tex' }
Plug 'nlknguyen/c-syntax.vim',              { 'for': 'c' }
Plug 'plasticboy/vim-markdown',             { 'for': 'markdown' }
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
set scrolloff=1
set sidescrolloff=5 " number of horizontal columns visible around cursor
set showmatch
set matchtime=2 " matching brackets cursor blink time (1/10 * n)
set hidden " hide unsaved buffer
set splitbelow
set splitright
set lazyredraw " do not redraw during macros
set linespace=0
set nolist " don't show invisble character
set listchars=tab:▸\ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:« " invisible character
" set statusline=%<\%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y\ %L\|%l:%c " disabled, using LightLine
"                 |  |   | | | |          |                        |       |   |   |  |
"                 |  |   | | | |          +-- encoding        i    |       |   |   |  +-- column
"                 |  |   | | | +--------------- preview            |       |   |   +----- line
"                 |  |   | | +----------------- help               |       |   +-------- total lines
"                 |  |   | +------------------- readonly           |       +------------ filetype
"                 |  |   +--------------------- modiied            +-------------------- format
"                 |  +------------------------- filepath
"                 +---------------------------- truncate from left
set noerrorbells
set novisualbell
set shortmess=aIOTF
"             |||||
"             ||||+-- hide file read messages
"             |||+--- truncate message in the middle
"             ||+---- no message on file changes (autoread)
"             |+----- no startup message
"             +------ use abbreviations
set display+=lastline
set conceallevel=2
set concealcursor=nv

" Diff
set diffopt=filler,vertical
"              |      |
"              |      +-- open diff in vertical mode
"              +--------- show filler lines

" Completion
set infercase
set complete-=i
"             |
"             +-- scan current and included files
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
set backspace=indent,start,eol " backspace over indentation, insert position and end of line
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
set nospell " no spellcheck
set spellfile=$XDG_CONFIG_HOME/nvim/spell/spellfile.utf-8.add
set spelllang=en
set clipboard=unnamed " use os clipboard
set formatoptions=qcnrj
"                 |||||
"                 |||||
"                 ||||+-- delete comment character when joining comments
"                 |||+--- insert comment leader after enter
"                 ||+---- recognize numbered lists
"                 |+----- auto-wrap comments using textwidth
"                 +------ allow formatting comments
set nrformats-=octal
"               |
"               +-- interpret numbers with leading zeros as octal

" Sync
set synmaxcol=256
syntax sync minlines=256
syntax sync maxlines=512

" Timeout
set ttimeout
set ttimeoutlen=100

" Session
set sessionoptions-=options,buffers,tabpages,help

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
    echom 'colorscheme not found'
endtry

" Fileglob
set wildmenu " enable filepath completion in the command bar
set wildmode=longest,full
set wildchar=<tab>
set wildignore+=*~,*sw[op],*.pid,.DS_Store
set wildignore+=.git,.hg,.svn,.bzr
set wildignore+=*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib
set wildignore+=*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso
set wildignore+=*.pdf,*.doc*,*.aux,*.out,*.toc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp,*.psd,*.ai,*.ico
set wildignore+=*.db,*.sqlite

" Leader
let g:mapleader=',' " `\` no thank you

" Keymap
nnoremap <leader>c :lclose \| cclose \| helpclose<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>f :echo expand("%:p")<cr>
nnoremap <leader>q :quitall<cr>
nnoremap <leader>w :write<cr>
nnoremap <leader>W :write !sudo tee %<cr>
nnoremap <leader>x :exit<cr>

nnoremap <leader><esc> :setlocal hlsearch!<cr>
nnoremap <leader>i     :setlocal list!<cr>
nnoremap <leader>s     :setlocal spell!<cr>

" Go to mark
nnoremap gm `

" Jump to next buffer
nnoremap <c-h> :bprev<cr>
nnoremap <c-l> :bnext<cr>

" Move line/visual selection vertically
nnoremap <c-j> :move .+1<cr>
nnoremap <c-k> :move .-2<cr>
vnoremap <c-j> :move '>+1'<cr>gv=gv
vnoremap <c-k> :move '<-2'<cr>gv=gv

" Speed up horizontal scroll
nnoremap zl 5zl
nnoremap zh 5zh

" Yank until line end
nnoremap Y y$

" Reverse f,t,F,T jump direction
nnoremap ; ,
nnoremap , ;

" Jump over wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Center screen when jumping between search matches
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Do not lose visual selection while indenting
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Increment/decrement number
nnoremap + <c-a>
nnoremap - <c-x>

" Walk history with j/k
cnoremap <c-j> <down>
cnoremap <c-k> <up>

" Search for visual selected
vnoremap <silent>* :<c-u>
  \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
  \ gvy/<c-r><c-r>=substitute(
  \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<cr><cr>
  \ gV:call setreg('"', old_reg, old_regtype)<cr>
vnoremap <silent># :<c-u>
  \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
  \ gvy?<c-r><c-r>=substitute(
  \ escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<cr><cr>
  \ gV:call setreg('"', old_reg, old_regtype)<cr>

" Tmux-like pane switching
function! s:panebind()
    let l:i=1
    while l:i <= 9
        execute 'nnoremap <silent><c-w>'.l:i.' :call <sid>choosepane('.l:i.')<cr>'
        let l:i+=1
    endwhile
endfunction
call s:panebind()

function! s:choosepane(nr)
    if a:nr <= winnr('$')
        execute a:nr.'wincmd w'
    else
        echom 'Can''t find pane '.a:nr
    endif
endfunction

augroup trigger
autocmd!

" Trigger: Title
autocmd BufEnter,VimEnter * let &titlestring=expand("%:t")
autocmd VimLeave          * let &titlestring=''

" Trigger: Remember cursor position
autocmd BufReadPost * if &filetype !~? 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Trigger: Switch between relative/norelative numbers in insert mode
autocmd InsertEnter,WinLeave,FocusLost   * if &filetype !~? 'help\|undotree\|GV\|gitcommit\|git\|diff' | setlocal norelativenumber | endif
autocmd InsertLeave,WinEnter,FocusGained * if &filetype !~? 'help\|undotree\|GV\|gitcommit\|git\|diff' | setlocal relativenumber | endif

" Trigger: Cursorline
autocmd WinEnter,FocusGained * setlocal cursorline
autocmd WinLeave,FocusLost * setlocal nocursorline

augroup end

augroup custom
autocmd!

" Custom: Filetype
autocmd BufNewFile,BufRead *.cls,*.sty                   setlocal filetype=tex
autocmd BufNewFile,BufRead *.frag,*.vert,*.shader,*.glsl setlocal filetype=glsl
autocmd BufNewFile,BufRead gitcommit                     setlocal filetype=gitcommit
autocmd BufNewFile,BufRead gitconfig                     setlocal filetype=gitconfig

" Custom: Indent
autocmd FileType c,cpp setlocal cindent
autocmd FileType make,go,c,cpp,glsl setlocal softtabstop=8 shiftwidth=8 noexpandtab
autocmd FileType yaml,toml,json,ruby,javascript,css,scss,html setlocal softtabstop=2 shiftwidth=2

" Custom: Spelling
autocmd FileType markdown,gitcommit setlocal spell

" Custom: Textwidth
autocmd FileType gitcommit     setlocal textwidth=72
autocmd FileType text,markdown setlocal textwidth=80

" Custom: Colorcolumn
autocmd FileType python,c,cpp  setlocal colorcolumn=81
autocmd FileType text,markdown setlocal colorcolumn=+1
autocmd FileType gitcommit     setlocal colorcolumn=51,+1

" Custom: Disable decoration
autocmd FileType qf,diff,git,gitcommit,GV setlocal nonumber norelativenumber

augroup end

" Colors: Spelling Errors
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=1

" Plugin: vim-markdown
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_fenced_languages=[
    \ 'bash=sh',
    \ 'conf',
    \ 'make',
    \ 'go',
    \ 'python',
    \ 'rust',
    \ 'c',
    \ 'vim',
    \ ]

" Plugin: neomake
noremap <leader><space> :Neomake<cr>
let g:neomake_serialize=1
let g:neomake_open_list=0
let g:neomake_go_enabled_makers=['go', 'govet']
let g:neomake_c_enabled_makers=['clang']
let g:neomake_warning_sign={
    \ 'text': '!',
    \ 'texthl': 'WarningMsg',
    \ }
let g:neomake_error_sign={
    \ 'text': '>',
    \ 'texthl': 'ErrorMsg',
    \ }

augroup neomaketrigger
autocmd!
autocmd FileType go autocmd BufWritePost * Neomake
autocmd FileType vim autocmd BufWritePost * Neomake
augroup end

" Plugin: fzf
noremap <c-p>     :FZFopen<cr>
noremap <leader>b :FZFBuffer<cr>
noremap <leader>o :FZFMru<cr>
let g:fzf_launcher='xterm -e fish -ic %s'

function! s:buflist()
    redir => l:ls
    silent ls
    redir end
    return split(l:ls, '\n')
endfunction

function! s:bufopen(e)
    execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! FZFopen call fzf#run({
    \ 'sink': 'e ',
    \ 'options': '+m',
    \ 'down': '100%'
    \ })

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
let g:ag_prg='ag --vimgrep --smart-case'
let g:ag_mapping_message=0

" Plugin: vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<leader>m'
let g:multi_cursor_next_key='<c-n>'
let g:multi_cursor_prev_key='<c-p>'
let g:multi_cursor_skip_key='<c-x>'
let g:multi_cursor_quit_key='<esc>'

" Plugin: vim-gitgutter
nmap gn <plug>GitGutterNextHunk
nmap gp <plug>GitGutterPrevHunk
let g:gitgutter_override_sign_column_highlight=0
let g:gitgutter_sign_column_always=1
let g:gitgutter_realtime=1
let g:gitgutter_eager=1
let g:gitgutter_map_keys=0

" Plugin: python-mode
let g:pymode_rope=0

" Plugin: rust.vim
let g:rustfmt_autosave=1

" Plugin: vim-go
let g:go_fmt_command='goimports'
let g:go_fmt_fail_silently=1
let g:go_doc_keywordprg_enabled=1

" Plugin: vim-better-whitespace
noremap <leader>I :ToggleWhitespace<cr>
let g:better_whitespace_filetypes_blacklist=['git', 'diff']

" Plugin: auto-pairs
let g:AutoPairsMapCR=0 " no funny stuff on carriage return

augroup autopairsextend
autocmd!
autocmd FileType markdown let b:AutoPairs={'(': ')', '[': ']', '{': '}', "'": "'", '"': '"', '`': '`', '$': '$', '_': '_'}
augroup end

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

" Plugin: comittia.vim
let g:committia_open_only_vim_starting=0
let g:committia_min_window_width=160
let g:committia_hooks={}

function! g:committia_hooks.diff_open(info)
    setlocal nonumber
    setlocal norelativenumber
endfunction

function! g:committia_hooks.status_open(info)
    setlocal nonumber
    setlocal norelativenumber
endfunction

function! g:committia_hooks.edit_open(info)
    imap <buffer><c-j> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><c-k> <Plug>(committia-scroll-diff-up-half)
    imap <buffer><c-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><c-p> <Plug>(committia-scroll-diff-up-half)
    nmap <buffer><c-j> <Plug>(committia-scroll-diff-down-half)
    nmap <buffer><c-k> <Plug>(committia-scroll-diff-up-half)
    nmap <buffer><c-n> <Plug>(committia-scroll-diff-down-half)
    nmap <buffer><c-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" Plugin: lightline.vim
let g:responsive_width=70
let g:omit_fileencoding='utf-8'
let g:omit_fileformat='unix'
let g:lightline={
    \ 'colorscheme': 'gotham',
    \ 'active': {
    \     'left': [
    \         ['mode'],
    \         ['fugitive', 'obsession'],
    \         ['filename', 'readonly', 'modified']
    \     ],
    \     'right': [
    \         ['percent', 'windownr'],
    \         ['lineinfo'],
    \         ['filetype', 'fileformat', 'fileencoding']
    \     ]
    \ },
    \ 'inactive': {
    \     'left': [
    \         ['filename']
    \     ],
    \     'right': [
    \         ['windownr']
    \     ]
    \ },
    \ 'component': {
    \     'lineinfo': ' %l:%-2v',
    \ },
    \ 'component_function': {
    \     'fugitive': 'LightLineFugitive',
    \     'obsession': 'LightLineObsession',
    \     'readonly': 'LightLineReadonly',
    \     'fileformat': 'LightLineFileformat',
    \     'fileencoding': 'LightLineFileencoding',
    \     'filetype': 'LightLineFiletype',
    \     'percent': 'LightLinePercent',
    \     'windownr': 'LightLineWindownr',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ }

function! LightLineFugitive()
    if winwidth(0) > g:responsive_width && exists('*fugitive#head')
        let l:head=fugitive#head()
        return l:head != '' ? ' '.l:head : ''
    endif
    return ''
endfunction

function! LightLineObsession()
    return winwidth(0) > g:responsive_width ?
        \ (exists('*ObsessionStatus') ? ObsessionStatus('↺ session') : '') : ''
endfunction

function! LightLineWindownr()
    return winnr('$') > 1 ? printf('⧉ %d', winnr()) : ''
endfunction

function! LightLineReadonly()
    return winwidth(0) > g:responsive_width ?
        \ (&filetype !~? 'help\|undotree' && &readonly ? '' : '') : ''
endfunction

function! LightLineModified()
    return winwidth(0) > g:responsive_width ?
        \ (&filetype !~? 'help\|undotree' ? '' : &modified ? '+' : &modifiable ? '' : '-') : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > g:responsive_width ?
        \ (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > g:responsive_width ?
        \ (&fileformat !=# g:omit_fileformat ? &fileformat : '') : ''
endfunction

function! LightLinePercent()
    return winwidth(0) > g:responsive_width ?
        \ printf('%2d%%', line('.') * 100 / line('$')) : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > g:responsive_width ?
        \ (&fileencoding !=# '' ?
            \ (&fileencoding !=# g:omit_fileencoding ? &fileencoding : '') :
                \ (&encoding !=# g:omit_fileencoding ? &encoding : '')) : ''
endfunction

" Plugin: neosnippet.vim
let g:neosnippet#disable_runtime_snippets={ '_' : 1 }
let g:neosnippet#snippets_directory=$XDG_CONFIG_HOME.'/nvim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1

" Plugin: deocomplete.nvim
smap <silent><expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_jump)"      : "\<tab>"
imap <silent><expr><tab> pumvisible()          ? "\<c-n>"                        : neosnippet#jumpable()   ? "\<plug>(neosnippet_jump)"   : "\<tab>"
imap <silent><expr><cr>  !pumvisible()         ? "\<cr>\<plug>AutoPairsReturn"   : neosnippet#expandable() ? "\<plug>(neosnippet_expand)" : deoplete#mappings#close_popup()
imap <silent><expr><esc> pumvisible()          ? deoplete#mappings#close_popup() : "\<esc>"
imap <silent><expr><bs>  deoplete#mappings#smart_close_popup()."\<bs>"
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_completion_start_length=1
let g:deoplete#enable_camel_case=1
let g:deoplete#max_list=100
let g:deoplete#ignore_sources={}
let g:deoplete#ignore_sources._=['buffer']
let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#clang#libclang_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang'
let g:deoplete#sources#clang#std#c='c11'
let g:deoplete#sources#clang#std#cpp='c++11'
