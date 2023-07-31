-- Leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Init package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- -- Fast experimental lua loader
-- vim.loader.enable()

-- -- Python
-- vim.g.loaded_python3_provider = 1
-- vim.g.python3_host_prod = vim.fn.expand('$HOME/.pyenv/versions/3.9.17/bin/python')

-- -- Disable providers
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_node_provider = 0

-- Configure package manager
require('lazy').setup({
  -- plugins
  {
    'whatyouhide/vim-gotham',
    lazy = false,
    priority = 1000
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      {
        'williamboman/mason-lspconfig.nvim',
      },
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {}
      },
      {
        'folke/neodev.nvim',
        opts = {}
      }
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'ethanholz/nvim-lastplace',
    lazy = false,
    opts = {
      lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
      lastplace_ignore_filetype = { 'gitcommit', 'gitrebase' },
      lastplace_open_folds = false
    }
  },
  {
    'rhysd/committia.vim',
    lazy = false,
    config = function()
      vim.g.committia_open_only_vim_starting = 0
      vim.g.committia_min_window_width = 160
      vim.g.committia_hooks = vim.empty_dict()
    end
  },
  {
    'tpope/vim-fugitive'
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    }
  },
  {
    'editorconfig/editorconfig-vim',
    lazy = false,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    opts = {
      char = '┊'
    }
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = true
  },
  {
    'nvim-lualine/lualine.nvim',
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
        return string.format('⧉ %d', vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
      end
      require('lualine').setup({
        options = {
          theme = gotham_lualine,
          always_divide_middle = true,
          icons_enabled = false,
          section_separators = '',
          component_separators = '|',
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
          lualine_a = { { 'buffers', mode = 4 } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = { { 'buffers', mode = 4 } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end
  }
}, {
  -- opts
  defaults = { lazy = true },
  performance = {
    disabled_plugins = {
      rtp = {
        'getscript',
        'getscriptPlugin',
        'gzip',
        'matchit',
        'matchparen',
        'netrw',
        'netrwFileHandlers',
        'netrwPlugin',
        'rrhelper',
        'tar',
        'tarPlugin',
        'tohtml',
        'tutor',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
      },
    },
  },
})

-- Title
vim.o.titlestring = [[%t]]

-- File
vim.o.encoding = 'utf-8'

-- State
vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('state') .. '/backup'
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('state') .. '/undo'
vim.o.shada = "'100,<500,/50,:100,@100,s10,h,c,n" .. vim.fn.stdpath('state') .. '/shada'

-- Cursor
vim.o.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'

-- Color
vim.cmd([[colorscheme gotham]])
vim.cmd([[highlight IndentBlanklineChar ctermfg=12 cterm=nocombine]])

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

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
vim.o.laststatus = 2    -- always show statusline
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5 -- number of horizontal columns visible around cursor
vim.o.showmatch = true
vim.o.matchtime = 2     -- matching brackets cursor blink time (1/10 * n)
vim.o.hidden = true     -- hide unsaved buffer
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.lazyredraw = true -- do not redraw during macros
vim.o.linespace = 0
vim.o.list = true
vim.o.listchars = 'tab:▸ ,trail:⋅,eol:¬,nbsp:_,extends:»,precedes:«' -- invisible character
vim.o.shortmess = 'aIOTF'
--               |||||
--               ||||+-- hide file read messages
--               |||+--- truncate message in the middle
--               ||+---- no message on file changes (autoread)
--               |+----- no startup message
--               +------ use abbreviations

-- Diff
vim.o.diffopt = 'filler,vertical'
--               |      |
--               |      +-- open diff in vertical mode
--               +--------- show filler lines

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true  -- highlight search
vim.o.incsearch = true -- highlight search string while typing
vim.o.magic = true     -- use backslashes for magic characters
vim.o.wrapscan = false

-- Editing
vim.o.gdefault = true                -- substitute globally by default
vim.o.backspace = 'indent,start,eol' -- backspace over indentation, insert position and end of line
vim.o.virtualedit = 'block'          -- use block selection in visual mode instead of longest column
vim.o.tabstop = 8                    -- number of spaces a tab counts for
vim.o.softtabstop = 4                -- number of spaces while indenting
vim.o.shiftwidth = 4                 -- number of spaces while shifting
vim.o.expandtab = true               -- use spaces rather than tabs
vim.o.smarttab = true                -- handle spaces like tabs while deleting them
vim.o.shiftround = true              -- round to a multiple of shiftwidth while indenting
vim.o.wrap = true                    -- don't wrap lines
vim.o.linebreak = true               -- don't break words at line end
vim.o.autoindent = true              -- auto indent next line
vim.o.copyindent = true              -- use the same indentation for autoindent
vim.o.smartindent = true             -- do smart autoindenting when starting a new line
vim.o.startofline = false            -- cursor stays at same column while moving horizontal
vim.o.joinspaces = false             -- do not add additional spaces on join
vim.o.spell = false                  -- no spellcheck
vim.o.spellfile = vim.fn.stdpath('data') .. '/spell/spellfile.utf-8.add'
vim.o.spelllang = 'en'
vim.o.clipboard = 'unnamed'
vim.o.formatoptions = 'qcnrj'
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
vim.o.mouse = 'nvc'
--             |||
--             ||+-- commandline mode
--             |+--- visual mode
--             +---- normal mode
vim.o.mousehide = true

-- Filetype glob
vim.o.wildmenu = true -- enable filepath completion in the command bar
vim.o.wildmode = 'longest,full'
vim.o.wildchar = '<tab>'
vim.o.wildignore = '*~,*sw[op],*.pid,.DS_Store'
vim.o.wildignore = vim.o.wildignore .. ',.git,.hg,.svn,.bzr'
vim.o.wildignore = vim.o.wildignore .. ',*.o,*.so,*.d,*.a,*.pyc,*.obj,*.lib'
vim.o.wildignore = vim.o.wildignore .. ',*.zip,*.tar,*.bz2,*.gz,*.xz,*.rar,*.iso'
vim.o.wildignore = vim.o.wildignore .. ',*.pdf,*.doc*,*.aux,*.out,*.toc'
vim.o.wildignore = vim.o.wildignore .. ',*.jpg,*.jpeg,*.png,*.gif,*.tiff,*.eps,*.bmp,*.psd,*.ai,*.ico,*.sketch'
vim.o.wildignore = vim.o.wildignore .. ',*.db,*.sqlite'


-- Trigger: Filetype indent
vim.api.nvim_create_autocmd('Filetype', {
  pattern = { 'lua' },
  command = 'setlocal shiftwidth=2 softtabstop=2'
})

-- Keymap: Process & io
vim.api.nvim_set_keymap('n', '<leader>q', ':quitall<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><s-q>', ':quitall!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':write<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><s-w>', ':write<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':lclose|cclose|helpclose<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':bd<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':echo expand("%:p")<cr>', { noremap = true })

-- Keymap: Move to next/prev buffer
vim.api.nvim_set_keymap('n', '<c-h>', ':bprev<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', ':bnext<cr>', { noremap = true })

-- Keymap: Remove search highlight
vim.api.nvim_set_keymap('n', '<leader><esc>', ':setlocal nohlsearch<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '/', ':setlocal hlsearch<cr>/', { noremap = true })

-- Keymap: Reverse jump direction
vim.api.nvim_set_keymap('n', ';', ',', { noremap = true })
vim.api.nvim_set_keymap('n', ',', ';', { noremap = true })

-- Keymap: ove line/visual selection vertically
vim.api.nvim_set_keymap('n', '<c-j>', ':move .+1<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-k>', ':move .-2<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<c-j>', ":move '>+1'<cr>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<c-k>', ":move '<-2'<cr>gv=gv", { noremap = true, silent = true })

-- Keymap: Yank until end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Keymap: Jump over wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })

-- Keymap: Indenting
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Keymap: Walk history with j/k
vim.api.nvim_set_keymap('c', '<c-j>', '<down>', { noremap = true })
vim.api.nvim_set_keymap('c', '<c-k>', '<up>', { noremap = true })

-- Colors: barbar.nvim
vim.api.nvim_set_hl(0, 'BufferCurrent', { ctermbg = 2, ctermfg = 0 })
vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { ctermbg = 2, ctermfg = 12 })
vim.api.nvim_set_hl(0, 'BufferCurrentMod', { ctermbg = 2, ctermfg = 12 })
vim.api.nvim_set_hl(0, 'BufferCurrentSign', { ctermbg = 2, ctermfg = 12 })
vim.api.nvim_set_hl(0, 'BufferInactive', { ctermbg = 10, ctermfg = 14 })
vim.api.nvim_set_hl(0, 'BufferInactiveIndex', { ctermbg = 10, ctermfg = 14 })
vim.api.nvim_set_hl(0, 'BufferInactiveMod', { ctermbg = 10, ctermfg = 14 })
vim.api.nvim_set_hl(0, 'BufferInactiveSign', { ctermbg = 10, ctermfg = 14 })
vim.api.nvim_set_hl(0, 'BufferTabpageFill', { ctermbg = 8, ctermfg = 6 })
vim.api.nvim_set_hl(0, 'BufferOffset', { ctermbg = 1, ctermfg = 1 })

-- Plugin: Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable FZF
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  gopls = {},
  pyright = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}


-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
  },
}
