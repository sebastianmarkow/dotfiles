-- Leader
vim.g.mapleader = [[,]]
vim.g.maplocalleader = [[ ]]

-- Init package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

-- Python
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prod = vim.fn.expand('$HOME/.pyenv/versions/3.8.16/bin/python')

-- Disable providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0


vim.g.coq_settings = {
  keymap = { recommended = false },
  auto_start = 'shut-up',
  clients = {
    tmux = { enabled = true },
  },
}

-- Configure package manager
require("lazy").setup({
    -- plugins
    {
      "lewis6991/impatient.nvim",
      lazy = false,
    },
    {
      "ibhagwan/fzf-lua",
      lazy = false,
      config = true
    },
    {
      "whatyouhide/vim-gotham",
      lazy = false,
      priority = 1000
    },
    {
      "ethanholz/nvim-lastplace",
      lazy = false,
      opts = {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase"},
        lastplace_open_folds = false
      }
    },
    {
      "rhysd/committia.vim",
      lazy = false,
      config = function()
        vim.g.committia_open_only_vim_starting = 0
        vim.g.committia_min_window_width = 160
        vim.g.committia_hooks = vim.empty_dict()
      end
    },
    {
      "lewis6991/gitsigns.nvim",
      lazy = false,
      config = true
    },
    {
      "editorconfig/editorconfig-vim",
      lazy = false,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      lazy = false,
      opts = {
        char = "┊"
      }
    },
    {
      "numToStr/Comment.nvim",
      lazy = false,
      config = true,
    },
    {
      "nvim-lualine/lualine.nvim",
      lazy = false,
      config = function()
        local colors = {
          base03 = 0,
          base02 = 8,
          base01 = 10,
          base00 = 12,
          base0 = 11,
          base1 = 14,
          base2 = 7,
          base3 = 15,
          red = 1,
          orange = 9,
          yellow = 3,
          magenta = 13,
          violet = 5,
          blue = 4,
          cyan = 6,
          green = 2,
        }
        gotham_lualine = {
          normal = {
            a = { bg = colors.blue, fg = colors.base3 },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
          insert = {
            a = { bg = colors.green, fg = colors.base3 },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
          visual = {
            a = { bg = colors.violet, fg = colors.base3 },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
          replace = {
            a = { bg = colors.red, fg = colors.base3 },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
          command = {
            a = { bg = colors.violet, fg = colors.base3 },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
          inactive = {
            a = { bg = colors.base02, fg = colors.blue },
            b = { bg = colors.base01, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.base1 },
            z = { bg = colors.blue, fg = colors.base3 },
          },
        }
        local function window_number()
          return string.format("⧉ %d", vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
        end
        require("lualine").setup({
          options = {
            theme = gotham_lualine,
            always_divide_middle = true,
            icons_enabled = false,
            section_separators = "",
            component_separators = "|",
          },
          extensions = {},
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', { 'diff', colored = false }, 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = {},
            lualine_y = { 'filetype' },
            lualine_z = { 'location', window_number },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { window_number },
          },
          winbar = {
            lualine_a = {{ 'buffers', mode = 4 }},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          inactive_winbar = {
            lualine_a = {{ 'buffers', mode = 4 }},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
        })
      end
    },
    {
      "ms-jpq/coq_nvim",
      branch = 'coq',
      lazy = false,
      event = "InsertEnter",
      run = ':COQdeps',
    },
    {
      "ms-jpq/coq.artifacts",
      branch = 'artifacts',
      lazy = false,
    }
  }, {
  -- opts
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "getscript",
        "getscriptPlugin",
        "gzip",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "rrhelper",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
})

-- Title
vim.o.titlestring = [[%t]]

-- File
vim.o.encoding = "utf-8"

-- State
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.shada = "'100,<500,/50,:100,@100,s10,h,c,n"..vim.fn.stdpath("state").."/shada"

-- Cursor
vim.o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

-- Color
vim.cmd([[colorscheme gotham]])
vim.cmd([[highlight IndentBlanklineChar ctermfg=12 cterm=nocombine]])

-- Interface
vim.o.showmode = false -- current mode (insert, visual, etc)
vim.o.showcmd = true
vim.o.title = true
vim.o.foldenable = false
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.o.numberwidth = 3
vim.o.cmdheight = 1
vim.o.laststatus = 2 -- always show statusline
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5 -- number of horizontal columns visible around cursor
vim.o.showmatch = true
vim.o.matchtime = 2 -- matching brackets cursor blink time (1/10 * n)
vim.o.hidden = true -- hide unsaved buffer
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.lazyredraw = true -- do not redraw during macros
vim.o.linespace = 0
vim.o.list = true
vim.o.listchars = "tab:▸ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:«" -- invisible character
vim.o.shortmess="aIOTF"
--               |||||
--               ||||+-- hide file read messages
--               |||+--- truncate message in the middle
--               ||+---- no message on file changes (autoread)
--               |+----- no startup message
--               +------ use abbreviations

-- Diff
vim.o.diffopt = "filler,vertical"
--               |      |
--               |      +-- open diff in vertical mode
--               +--------- show filler lines

-- Completion

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true -- highlight search
vim.o.incsearch = true -- highlight search string while typing
vim.o.magic = true -- use backslashes for magic characters
vim.o.wrapscan = false

-- Editing
vim.o.gdefault = true -- substitute globally by default
vim.o.backspace = "indent,start,eol" -- backspace over indentation, insert position and end of line
vim.o.virtualedit = "block" -- use block selection in visual mode instead of longest column
vim.o.tabstop = 8 -- number of spaces a tab counts for
vim.o.softtabstop = 4 -- number of spaces while indenting
vim.o.shiftwidth = 4 -- number of spaces while shifting
vim.o.expandtab = true -- use spaces rather than tabs
vim.o.smarttab = true -- handle spaces like tabs while deleting them
vim.o.shiftround = true -- round to a multiple of shiftwidth while indenting
vim.o.wrap = true -- don't wrap lines
vim.o.linebreak = true -- don't break words at line end
vim.o.autoindent = true -- auto indent next line
vim.o.copyindent = true -- use the same indentation for autoindent
vim.o.smartindent = true -- do smart autoindenting when starting a new line
vim.o.startofline = false -- cursor stays at same column while moving horizontal
vim.o.joinspaces = false -- do not add additional spaces on join
vim.o.spell = false -- no spellcheck
vim.o.spellfile = vim.fn.stdpath("data").."/spell/spellfile.utf-8.add"
vim.o.spelllang = "en"
vim.o.clipboard = "unnamed"
vim.o.formatoptions="qcnrj"
--                   |||||
--                   |||||
--                   ||||+-- delete comment character when joining comments
--                   |||+--- insert comment leader after enter
--                   ||+---- recognize numbered lists
--                   |+----- auto-wrap comments using textwidth
--                   +------ allow formatting comments

-- Timing
vim.o.updatetime = 250
vim.o.ttimeoutlen = 100

-- Mouse
vim.o.mouse = "nvc"
--             |||
--             ||+-- commandline mode
--             |+--- visual mode
--             +---- normal mode
vim.o.mousehide = true

-- Filetype glob
vim.o.wildmenu = true -- enable filepath completion in the command bar
vim.o.wildmode = "longest,full"
vim.o.wildchar = "<tab>"
vim.o.wildignore = "*~,*sw[op],*.pid,.DS_Store"
vim.o.wildignore = vim.o.wildignore .. ",.git,.hg,.svn,.bzr"
vim.o.wildignore = vim.o.wildignore .. ",*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib"
vim.o.wildignore = vim.o.wildignore .. ",*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso"
vim.o.wildignore = vim.o.wildignore .. ",*.pdf,*.doc*,*.aux,*.out,*.toc"
vim.o.wildignore = vim.o.wildignore .. ",*.jpg,*.jpeg,*.png,*.gif,*.tiff,*.eps,*.bmp,*.psd,*.ai,*.ico,*.sketch"
vim.o.wildignore = vim.o.wildignore .. ",*.db,*.sqlite"


-- Trigger: Filetype indent
vim.api.nvim_create_autocmd("Filetype", {
    pattern = {"lua"},
    command = "setlocal shiftwidth=2 softtabstop=2"
})

-- Keymap: Process & io
vim.api.nvim_set_keymap("n", "<leader>q", ":quitall<cr>", {noremap = true})
  vim.api.nvim_set_keymap("n", "<leader><s-q>", ":quitall!<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>w", ":write<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader><s-w>", ":write<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>c", ":lclose|cclose|helpclose<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>f", ":echo expand('%:p')<cr>", {noremap = true})

-- Keymap: Move to next/prev buffer
vim.api.nvim_set_keymap("n", "<c-h>", ":bprev<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<c-l>", ":bnext<cr>", {noremap = true})

-- Keymap: Remove search highlight
vim.api.nvim_set_keymap("n", "<leader><esc>", ":setlocal nohlsearch<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "/", ":setlocal hlsearch<cr>/", {noremap = true})

-- Keymap: Reverse jump direction
vim.api.nvim_set_keymap("n", ";", ",", {noremap = true})
vim.api.nvim_set_keymap("n", ",", ";", {noremap = true})

-- Keymap: ove line/visual selection vertically
vim.api.nvim_set_keymap("n", "<c-j>", ":move .+1<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<c-k>", ":move .-2<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<c-j>", ":move '>+1'<cr>gv=gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<c-k>", ":move '<-2'<cr>gv=gv", {noremap = true, silent = true})

-- Keymap: Yank until end of line
vim.api.nvim_set_keymap("n", "Y", "y$", {noremap = true})

-- Keymap: Jump over wrapped lines
vim.api.nvim_set_keymap("n", "j", "gj", {noremap = true})
vim.api.nvim_set_keymap("n", "k", "gk", {noremap = true})
vim.api.nvim_set_keymap("n", "gj", "j", {noremap = true})
vim.api.nvim_set_keymap("n", "gk", "k", {noremap = true})

-- Keymap: Indenting
vim.api.nvim_set_keymap("n", "<", "<<", {noremap = true})
vim.api.nvim_set_keymap("n", ">", ">>", {noremap = true})
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true})

-- Keymap: Walk history with j/k
vim.api.nvim_set_keymap("c", "<c-j>", "<down>", {noremap = true})
vim.api.nvim_set_keymap("c", "<c-k>", "<up>", {noremap = true})

-- Colors: barbar.nvim
vim.api.nvim_set_hl(0, "BufferCurrent", {ctermbg=2, ctermfg=0})
vim.api.nvim_set_hl(0, "BufferCurrentIndex", {ctermbg=2, ctermfg=12})
vim.api.nvim_set_hl(0, "BufferCurrentMod", {ctermbg=2, ctermfg=12})
vim.api.nvim_set_hl(0, "BufferCurrentSign", {ctermbg=2, ctermfg=12})
vim.api.nvim_set_hl(0, "BufferInactive", {ctermbg=10, ctermfg=14})
vim.api.nvim_set_hl(0, "BufferInactiveIndex", {ctermbg=10, ctermfg=14})
vim.api.nvim_set_hl(0, "BufferInactiveMod", {ctermbg=10, ctermfg=14})
vim.api.nvim_set_hl(0, "BufferInactiveSign", {ctermbg=10, ctermfg=14})
vim.api.nvim_set_hl(0, "BufferTabpageFill", {ctermbg=8, ctermfg=6})
vim.api.nvim_set_hl(0, "BufferOffset", {ctermbg=1, ctermfg=1})

