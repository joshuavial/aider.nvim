vim.g.mapleader = vim.g.mapleader or " "

local wk = require("which-key")

wk.add({
  { "<leader>A",  group = "Aider" }, -- group
  { "<leader>AB", "<CMD>AiderBackground -3<CR>",    desc = "Run Aider (GPT-3.5) in Background", mode = "n" },
  { "<leader>AO", "<CMD>AiderOpen -3<CR>",          desc = "Open Aider (GPT-3.5)",              mode = "n" },
  { "<leader>Ab", "<CMD>AiderBackground<CR>",       desc = "Run Aider in Background",           mode = "n" },
  { "<leader>Am", "<CMD>AiderAddModifiedFiles<CR>", desc = "Add Modified Files to Chat",        mode = "n" },
  { "<leader>Ao", "<CMD>AiderOpen<CR>",             desc = "Open Aider",                        mode = "n" },
})

-- Set up the actual keybindings (these are redundant if using which-key, but included for completeness)
vim.keymap.set("n", "<leader>AB", "<CMD>AiderBackground -3<CR>", { desc = "Run Aider (GPT-3.5) in Background" })
vim.keymap.set("n", "<leader>AO", "<CMD>AiderOpen -3<CR>", { desc = "Open Aider (GPT-3.5)" })
vim.keymap.set("n", "<leader>Ab", "<CMD>AiderBackground<CR>", { desc = "Run Aider in Background" })
vim.keymap.set("n", "<leader>Am", "<CMD>AiderAddModifiedFiles<CR>", { desc = "Add Modified Files to Chat" })
vim.keymap.set("n", "<leader>Ao", "<CMD>AiderOpen<CR>", { desc = "Open Aider" })
