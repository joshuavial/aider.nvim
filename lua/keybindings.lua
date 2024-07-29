vim.g.mapleader = vim.g.mapleader or " "

local wk = require("which-key")

-- nice local funct!
local function aider_command_and_insert(cmd)
	return function()
		vim.cmd(cmd)
		vim.defer_fn(function()
			vim.cmd("startinsert")
		end, 100)
	end
end

wk.add({
	{ "<leader>A", group = "Aider" }, -- group
	{
		"<leader>AB",
		aider_command_and_insert("AiderBackground -3"),
		desc = "Run Aider (GPT-3.5) in Background",
		mode = "n",
	},
	{
		"<leader>AO",
		aider_command_and_insert("AiderOpen -3"),
		desc = "Open Aider (GPT-3.5)",
		mode = "n",
	},
	{
		"<leader>Ab",
		aider_command_and_insert("AiderBackground"),
		desc = "Run Aider in Background",
		mode = "n",
	},
	{
		"<leader>Am",
		aider_command_and_insert("AiderAddModifiedFiles"),
		desc = "Open Aider and add Git Modified Files to Chat",
		mode = "n",
	},
	{
		"<leader>Ao",
		aider_command_and_insert("AiderOpen"),
		desc = "Open Aider",
		mode = "n",
	},
})

-- Set up the actual keybindings (these are redundant if using which-key, but included for completeness)
vim.keymap.set(
	"n",
	"<leader>AB",
	aider_command_and_insert("AiderBackground -3"),
	{ desc = "Run Aider (GPT-3.5) in Background" }
)
vim.keymap.set("n", "<leader>AO", aider_command_and_insert("AiderOpen -3"), { desc = "Open Aider (GPT-3.5)" })
vim.keymap.set("n", "<leader>Ab", aider_command_and_insert("AiderBackground"), { desc = "Run Aider in Background" })
vim.keymap.set(
	"n",
	"<leader>Am",
	aider_command_and_insert("AiderAddModifiedFiles"),
	{ desc = "Add Modified Files to Chat" }
)
vim.keymap.set("n", "<leader>Ao", aider_command_and_insert("AiderOpen"), { desc = "Open Aider" })
