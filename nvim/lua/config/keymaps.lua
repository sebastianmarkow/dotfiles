-- Process & io
vim.api.nvim_set_keymap('n', 'q', ':quitall<cr>', { desc = 'Exit current window', silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':quitall<cr>', { desc = 'Exit neovim', silent = true })
vim.api.nvim_set_keymap('n', '<leader><s-q>', ':quitall!<cr>', { desc = 'Exit neovim without saving', silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':write<cr>', { desc = 'Write current buffer', silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':close<cr>', { desc = 'Close panel', silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':bd<cr>', { desc = 'Delete current buffer', silent = true })

-- Move to next/prev buffer
vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<s-tab>', ':bprev<cr>', { noremap = true, silent = true })

-- Set and remove search highlight
vim.api.nvim_set_keymap('n', '<leader><esc>', ':setlocal nohlsearch<cr>', { desc = 'Remove highlighting', silent = true })
vim.api.nvim_set_keymap('n', '/', ':setlocal hlsearch<cr>/', { noremap = true })

-- Yank until end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Jump over wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })

-- Indenting
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })
vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- Walk history with j/k
vim.api.nvim_set_keymap('c', '<c-j>', '<down>', { noremap = true })
vim.api.nvim_set_keymap('c', '<c-k>', '<up>', { noremap = true })

-- Do not yank while visual paste
vim.api.nvim_set_keymap('v', 'p', '"_dp', { noremap = true })
vim.api.nvim_set_keymap('v', 'P', '"_dP', { noremap = true })
