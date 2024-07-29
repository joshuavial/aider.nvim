vim.g.mapleader = vim.g.mapleader or " "

local wk = require("which-key")

wk.register({
	["<leader>A"] = {
		name = "Aider",
		b = { ":AiderBackground<CR>", "Run Aider in Background" },
		B = { ":AiderBackground -3<CR>", "Run Aider (GPT-3.5) in Background" },
		o = { ":AiderOpen<CR>", "Open Aider" },
		O = { ":AiderOpen -3<CR>", "Open Aider (GPT-3.5)" },
	},
})

-- Set up the actual keybindings
vim.api.nvim_set_keymap("n", "<leader>Ab", ":AiderBackground<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>AB", ":AiderBackground -3<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Ao", ":AiderOpen<CR>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>AO", ":AiderOpen -3<CR>i", { noremap = true, silent = true })
