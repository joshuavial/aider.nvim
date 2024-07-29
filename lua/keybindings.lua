vim.g.mapleader = vim.g.mapleader or " "

local wk = require("which-key")

wk.register({
  { "<leader>A", group = "Aider" },
  { "<leader>AB", ":AiderBackground -3<CR>", desc = "Run Aider (GPT-3.5) in Background" },
  { "<leader>AO", ":AiderOpen -3<CR>", desc = "Open Aider (GPT-3.5)" },
  { "<leader>Ab", ":AiderBackground<CR>", desc = "Run Aider in Background" },
  { "<leader>Am", ":AiderAddModifiedFiles<CR>", desc = "Add Modified Files to Chat" },
  { "<leader>Ao", ":AiderOpen<CR>", desc = "Open Aider" },
})

-- Set up the actual keybindings
vim.keymap.set("n", "<leader>AB", "<CMD>AiderBackground -3<CR>", { desc = "Run Aider (GPT-3.5) in Background" })
vim.keymap.set("n", "<leader>AO", "<CMD>AiderOpen -3<CR>", { desc = "Open Aider (GPT-3.5)" })
vim.keymap.set("n", "<leader>Ab", "<CMD>AiderBackground<CR>", { desc = "Run Aider in Background" })
vim.keymap.set("n", "<leader>Am", "<CMD>AiderAddModifiedFiles<CR>", { desc = "Add Modified Files to Chat" })
vim.keymap.set("n", "<leader>Ao", "<CMD>AiderOpen<CR>", { desc = "Open Aider" })
