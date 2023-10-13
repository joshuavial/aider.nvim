vim.g.mapleader = vim.g.mapleader or ' '
vim.api.nvim_set_keymap('n', '<leader> b', ':lua AiderBackground()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader> b3', ':lua AiderBackground("-3")<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>  ', ':lua AiderOpen()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader> 3', ':lua AiderOpen("-3")<CR>', {noremap = true, silent = true})
