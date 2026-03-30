vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Unload providers
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

vim.o.modelines = 0

-- Title
vim.o.titlestring = '%t'

-- State
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('state') .. '/backup'
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('state') .. '/undo'

-- Interface
vim.o.title = true
vim.o.number = true
vim.o.cursorline = true
vim.o.numberwidth = 3
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8 -- number of horizontal columns visible around cursor
vim.o.cmdheight = 0
vim.o.showcmd = false
vim.o.showmatch = true
vim.o.matchtime = 2 -- matching brackets cursor blink time (1/10 * n)
vim.o.hidden = true -- hide unsaved buffer
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.synmaxcol = 200
vim.o.redrawtime = 1000
vim.o.updatetime = 200
vim.o.timeoutlen = 500
vim.o.linespace = 0
vim.o.listchars = 'tab:▸ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:«' -- invisible character
vim.o.list = true
vim.o.fillchars = 'eob: '
vim.o.winborder = 'rounded'
vim.o.shortmess = 'CcFIoOsTtW'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true -- highlight search
vim.o.incsearch = true -- highlight search string while typing
vim.o.magic = true -- use backslashes for magic characters
vim.o.wrapscan = false

-- Editing
vim.o.gdefault = true -- substitute globally by default
vim.o.backspace = 'indent,start,eol' -- backspace over indentation, insert position and end of line
vim.o.virtualedit = 'block' -- use block selection in visual mode instead of longest column
vim.o.tabstop = 8 -- number of spaces a tab counts for
vim.o.softtabstop = 4 -- number of spaces while indenting
vim.o.shiftwidth = 4 -- number of spaces while shifting
vim.o.expandtab = true -- use spaces rather than tabs
vim.o.smarttab = true -- handle spaces like tabs while deleting them
vim.o.shiftround = true -- round to a multiple of shiftwidth while indenting
vim.o.foldlevel = 99
vim.o.wrap = false -- don"t wrap lines
vim.o.linebreak = true -- don"t break words at line end
vim.o.autoindent = true -- auto indent next line
vim.o.copyindent = true -- use the same indentation for autoindent
vim.o.smartindent = true -- do smart autoindenting when starting a new line
vim.o.startofline = false -- cursor stays at same column while moving horizontal
vim.o.joinspaces = true -- add extra space after '.', '?' and '!' on join
vim.o.clipboard = 'unnamed'
vim.o.formatoptions = 'qcnrj'
--                     |||||
--                     |||||
--                     ||||+-- delete comment character when joining comments
--                     |||+--- insert comment leader after enter
--                     ||+---- recognize numbered lists
--                     |+----- auto-wrap comments using textwidth
--                     +------ allow formatting comments

-- Mouse
vim.o.mousehide = true
vim.o.mouse = 'nvc'
--             |||
--             ||+-- commandline mode
--             |+--- visual mode
--             +---- normal mode

-- Sign Column
vim.o.signcolumn = 'yes:1'
vim.o.laststatus = 3

-- Filetype glob
vim.o.wildmenu = true -- enable filepath completion in the command bar
vim.o.wildmode = 'longest,full'
vim.o.wildignore = '*~,*sw[op],*.pid,.DS_Store'
  .. ',.git,.hg,.svn,.bzr'
  .. ',*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib'
  .. ',*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso'
  .. ',*.pdf,*.doc*,*.aux,*.out,*.toc'
  .. ',*.jpg,*.jpeg,*.png,*.gif,*.tiff,*.eps,*.bmp,*.psd,*.ai,*.ico,*.sketch'
  .. ',*.db,*.sqlite'
