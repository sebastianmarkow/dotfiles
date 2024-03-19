local globals = {
    mapleader = " ",
    maplocalleader = " ",

    -- Unload providers
    loaded_node_provider = 0,
    loaded_ruby_provider = 0,
    loaded_perl_provider = 0,
    loaded_python_provider = 0,
}

local options = {
    -- Security
    modelines = 0,

    -- Title
    titlestring = "%t",

    -- State
    backup = true,
    backupdir = vim.fn.stdpath("state") .. "/backup",
    swapfile = false,
    undofile = true,
    undodir = vim.fn.stdpath("state") .. "/undo",

    -- Interface
    showmode = false, -- current mode (insert, visual, etc),
    showcmd = true,
    title = true,
    foldenable = false,
    number = true,
    relativenumber = false,
    cursorline = true,
    numberwidth = 3,
    cmdheight = 1,
    laststatus = 2, -- always show statusline
    scrolloff = 5,
    sidescrolloff = 5, -- number of horizontal columns visible around cursor
    showmatch = true,
    matchtime = 2, -- matching brackets cursor blink time (1/10 * n)
    hidden = true, -- hide unsaved buffer
    splitbelow = true,
    splitright = true,
    lazyredraw = true, -- do not redraw during macros
    linespace = 0,
    list = true,
    listchars = "tab:▸ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:«", -- invisible character
    fillchars = "eob: ",
    shortmess = "aIOTF",
    --           |||||
    --           ||||+-- hide file read messages
    --           |||+--- truncate message in the middle
    --           ||+---- no message on file changes (autoread)
    --           |+----- no startup message
    --           +------ use abbreviations

    -- Search
    ignorecase = true,
    smartcase = true,
    hlsearch = true, -- highlight search
    incsearch = true, -- highlight search string while typing
    magic = true, -- use backslashes for magic characters
    wrapscan = false,

    -- Editing
    gdefault = true, -- substitute globally by default
    backspace = "indent,start,eol", -- backspace over indentation, insert position and end of line
    virtualedit = "block", -- use block selection in visual mode instead of longest column
    tabstop = 8, -- number of spaces a tab counts for
    softtabstop = 4, -- number of spaces while indenting
    shiftwidth = 4, -- number of spaces while shifting
    expandtab = true, -- use spaces rather than tabs
    smarttab = true, -- handle spaces like tabs while deleting them
    shiftround = true, -- round to a multiple of shiftwidth while indenting
    wrap = false, -- don"t wrap lines
    linebreak = true, -- don"t break words at line end
    autoindent = true, -- auto indent next line
    copyindent = true, -- use the same indentation for autoindent
    smartindent = true, -- do smart autoindenting when starting a new line
    startofline = false, -- cursor stays at same column while moving horizontal
    joinspaces = true, -- do not add additional spaces on join
    clipboard = "unnamed",
    formatoptions = "qcnrj",
    --               |||||
    --               |||||
    --               ||||+-- delete comment character when joining comments
    --               |||+--- insert comment leader after enter
    --               ||+---- recognize numbered lists
    --               |+----- auto-wrap comments using textwidth
    --               +------ allow formatting comments

    -- Mouse
    mouse = "nvc",
    --             |||
    --             ||+-- commandline mode
    --             |+--- visual mode
    --             +---- normal mode
    mousehide = true,

    timeoutlen = 2500,

    -- Sign Column
    signcolumn = "auto:4",

    -- Filetype glob
    wildmenu = true, -- enable filepath completion in the command bar
    wildmode = "longest,full",
    wildignore = "*~,*sw[op],*.pid,.DS_Store",
    wildignore = vim.o.wildignore .. ",.git,.hg,.svn,.bzr",
    wildignore = vim.o.wildignore .. ",*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib",
    wildignore = vim.o.wildignore .. ",*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso",
    wildignore = vim.o.wildignore .. ",*.pdf,*.doc*,*.aux,*.out,*.toc",
    wildignore = vim.o.wildignore .. ",*.jpg,*.jpeg,*.png,*.gif,*.tiff,*.eps,*.bmp,*.psd,*.ai,*.ico,*.sketch",
    wildignore = vim.o.wildignore .. ",*.db,*.sqlite",
}

for k, v in pairs(globals) do
    vim.g[k] = v
end

for k, v in pairs(options) do
    vim.o[k] = v
end
