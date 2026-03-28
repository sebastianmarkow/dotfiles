-- Process & io
vim.keymap.set('n', 'q', ':quit<cr>', { desc = 'Exit current window', silent = true })
vim.keymap.set('n', '<leader>q', ':quitall<cr>', { desc = 'Exit neovim', silent = true })
vim.keymap.set('n', '<leader><s-q>', ':quitall!<cr>', { desc = 'Exit neovim without saving', silent = true })
vim.keymap.set('n', '<leader>w', ':write<cr>', { desc = 'Write current buffer', silent = true })
vim.keymap.set('n', '<leader>c', ':close<cr>', { desc = 'Close panel', silent = true })
vim.keymap.set('n', '<leader>d', ':bd<cr>', { desc = 'Delete current buffer', silent = true })

-- Move to next/prev buffer
vim.keymap.set('n', '<tab>', ':bnext<cr>', { silent = true })
vim.keymap.set('n', '<s-tab>', ':bprev<cr>', { silent = true })

-- Set and remove search highlight
vim.keymap.set('n', '<leader><esc>', ':setlocal nohlsearch<cr>', { desc = 'Remove highlighting', silent = true })
vim.keymap.set('n', '/', ':setlocal hlsearch<cr>/', { noremap = true })

-- Yank until end of line
vim.keymap.set('n', 'Y', 'y$')

-- Jump over wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')

-- Indenting
vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Walk history with j/k
vim.keymap.set('c', '<c-j>', '<down>')
vim.keymap.set('c', '<c-k>', '<up>')

-- Do not yank while visual paste
vim.keymap.set('v', 'p', '"_dp')
vim.keymap.set('v', 'P', '"_dP')
