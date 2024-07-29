vim.g.mapleader = vim.g.mapleader or ' '

local wk = require("which-key")

wk.register({
  ["<leader>A"] = {
    name = "Aider",
    b = {
      name = "Background",
      b = { ":AiderBackground<CR>", "Run Aider in Background" },
      ["3"] = { ":AiderBackground -3<CR>", "Run Aider (GPT-3.5) in Background" },
    },
    o = {
      name = "Open",
      o = { ":AiderOpen<CR>", "Open Aider" },
      ["3"] = { ":AiderOpen -3<CR>", "Open Aider (GPT-3.5)" },
    },
  },
})

-- Set up the actual keybindings
vim.api.nvim_set_keymap('n', '<leader>Abb', ':AiderBackground<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Ab3', ':AiderBackground -3<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Aoo', ':AiderOpen<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>Ao3', ':AiderOpen -3<CR>', {noremap = true, silent = true})
