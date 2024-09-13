local keymap = vim.api.nvim_set_keymap

-- Keymap: Process & io
keymap('n', '<leader>q', ':quitall<cr>', { noremap = true })
keymap('n', '<leader><s-q>', ':quitall!<cr>', { noremap = true })
keymap('n', '<leader>w', ':write<cr>', { noremap = true })
keymap('n', '<leader><s-w>', ':write<cr>', { noremap = true })
keymap('n', '<leader>c', ':lclose|cclose|helpclose<cr>', { noremap = true })
keymap('n', '<leader>d', ':bd<cr>', { noremap = true })
keymap('n', '<leader>f', ':echo expand("%:p")<cr>', { noremap = true })

-- Keymap: Move to next/prev buffer
keymap('n', '<c-h>', ':bprev<cr>', { noremap = true })
keymap('n', '<c-l>', ':bnext<cr>', { noremap = true })

-- Keymap: Remove search highlight
keymap('n', '<leader><esc>', ':setlocal nohlsearch<cr>', { noremap = true, silent = true })
keymap('n', '/', ':setlocal hlsearch<cr>/', { noremap = true })

-- Keymap: Reverse jump direction
keymap('n', ';', ',', { noremap = true })
keymap('n', ',', ';', { noremap = true })

-- Keymap: ove line/visual selection vertically
keymap('n', '<c-j>', ':move .+1<cr>', { noremap = true, silent = true })
keymap('n', '<c-k>', ':move .-2<cr>', { noremap = true, silent = true })
keymap('v', '<c-j>', ':move \'>+1\'<cr>gv=gv', { noremap = true, silent = true })
keymap('v', '<c-k>', ':move \'<-2\'<cr>gv=gv', { noremap = true, silent = true })

-- Keymap: Yank until end of line
keymap('n', 'Y', 'y$', { noremap = true })

-- Keymap: Jump over wrapped lines
keymap('n', 'j', 'gj', { noremap = true })
keymap('n', 'k', 'gk', { noremap = true })
keymap('n', 'gj', 'j', { noremap = true })
keymap('n', 'gk', 'k', { noremap = true })

-- Keymap: Indenting
keymap('n', '<', '<<', { noremap = true })
keymap('n', '>', '>>', { noremap = true })
keymap('v', '<', '<gv', { noremap = true })
keymap('v', '>', '>gv', { noremap = true })

-- Keymap: Walk history with j/k
keymap('c', '<c-j>', '<down>', { noremap = true })
keymap('c', '<c-k>', '<up>', { noremap = true })
