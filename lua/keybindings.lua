vim.g.mapleader = vim.g.mapleader or " "

-- Check if which-key is available
local status_ok, wk = pcall(require, "which-key")
local use_which_key = status_ok

-- nice local funct!
local function aider_command_and_insert(cmd)
	return function()
		vim.cmd(cmd)
		vim.defer_fn(function()
			vim.cmd("startinsert")
		end, 100)
	end
end

if use_which_key then
	wk.add({
		{
			"<leader>A",
			group = "Aider",
		},
		{
			"<leader>Am",
			"<CMD>AiderAddModifiedFiles<CR>",
			desc = "Add Modified Files to Chat",
			mode = "n",
		},
		{
			"<leader>Ao",
			"<CMD>AiderOpen<CR>",
			desc = "Open Aider",
			mode = "n",
		},
	})
else
	-- Set up the actual keybindings when which-key is not available
	vim.keymap.set(
		"n",
		"<leader>Am",
		aider_command_and_insert("AiderAddModifiedFiles"),
		{ desc = "Add Modified Files to Chat" }
	)
	vim.keymap.set("n", "<leader>Ao", aider_command_and_insert("AiderOpen"), { desc = "Open Aider" })
end
