-- Keymap: Process & io
vim.api.nvim_set_keymap("n", "<leader>q", ":quitall<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><s-q>", ":quitall!<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":write<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><s-w>", ":write<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":lclose|cclose|helpclose<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>f", ':echo expand("%:p")<cr>', { noremap = true })

-- Keymap: Move to next/prev buffer
vim.api.nvim_set_keymap("n", "<c-h>", ":bprev<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-l>", ":bnext<cr>", { noremap = true })

-- Keymap: Remove search highlight
vim.api.nvim_set_keymap("n", "<leader><esc>", ":setlocal nohlsearch<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "/", ":setlocal hlsearch<cr>/", { noremap = true })

-- Keymap: Reverse jump direction
vim.api.nvim_set_keymap("n", ";", ",", { noremap = true })
vim.api.nvim_set_keymap("n", ",", ";", { noremap = true })

-- Keymap: ove line/visual selection vertically
vim.api.nvim_set_keymap("n", "<c-j>", ":move .+1<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<c-k>", ":move .-2<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<c-j>", ":move '>+1'<cr>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<c-k>", ":move '<-2'<cr>gv=gv", { noremap = true, silent = true })

-- Keymap: Yank until end of line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Keymap: Jump over wrapped lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "gj", "j", { noremap = true })
vim.api.nvim_set_keymap("n", "gk", "k", { noremap = true })

-- Keymap: Indenting
vim.api.nvim_set_keymap("n", "<", "<<", { noremap = true })
vim.api.nvim_set_keymap("n", ">", ">>", { noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })

-- Keymap: Walk history with j/k
vim.api.nvim_set_keymap("c", "<c-j>", "<down>", { noremap = true })
vim.api.nvim_set_keymap("c", "<c-k>", "<up>", { noremap = true })
