vim.g.mapleader = vim.g.mapleader or ' '
vim.api.nvim_set_keymap('n', '<leader> b', ':AiderBackground<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader> b3', ':AiderBackground -3<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>  ', ':AiderOpen<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader> 3', ':AiderOpen -3<CR>', {noremap = true, silent = true})
