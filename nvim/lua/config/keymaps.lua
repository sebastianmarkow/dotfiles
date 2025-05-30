local keymap = vim.api.nvim_set_keymap

-- Process & io
keymap('n', 'q', ':quitall<cr>', { desc = 'Exit current window', silent = true })
keymap('n', '<leader>q', ':quitall<cr>', { desc = 'Exit neovim', silent = true })
keymap('n', '<leader><s-q>', ':quitall!<cr>', { desc = 'Exit neovim without saving', silent = true })
keymap('n', '<leader>w', ':write<cr>', { desc = 'Write current buffer', silent = true })
keymap('n', '<leader>c', ':close<cr>', { desc = 'Close panel', silent = true })
keymap('n', '<leader>d', ':bd<cr>', { desc = 'Delete current buffer', silent = true })

-- Move to next/prev buffer
keymap('n', '<tab>', ':bnext<cr>', { noremap = true, silent = true })
keymap('n', '<s-tab>', ':bprev<cr>', { noremap = true, silent = true })

-- Set and remove search highlight
keymap('n', '<leader><esc>', ':setlocal nohlsearch<cr>', { desc = 'Remove highlighting', silent = true })
keymap('n', '/', ':setlocal hlsearch<cr>/', { noremap = true })

-- Yank until end of line
keymap('n', 'Y', 'y$', { noremap = true })

-- Jump over wrapped lines
keymap('n', 'j', 'gj', { noremap = true })
keymap('n', 'k', 'gk', { noremap = true })
keymap('n', 'gj', 'j', { noremap = true })
keymap('n', 'gk', 'k', { noremap = true })

-- Indenting
keymap('n', '<', '<<', { noremap = true })
keymap('n', '>', '>>', { noremap = true })
keymap('v', '<', '<gv', { noremap = true })
keymap('v', '>', '>gv', { noremap = true })

-- Walk history with j/k
keymap('c', '<c-j>', '<down>', { noremap = true })
keymap('c', '<c-k>', '<up>', { noremap = true })

-- Do not yank while visual paste
keymap('v', 'p', '"_dp', { noremap = true })
keymap('v', 'P', '"_dP', { noremap = true })
