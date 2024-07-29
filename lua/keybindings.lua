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
    wk.register({
        ["<leader>A"] = { name = "Aider" },
        ["<leader>AB"] = { aider_command_and_insert("AiderBackground -3"), "Run Aider (GPT-3.5) in Background" },
        ["<leader>AO"] = { aider_command_and_insert("AiderOpen -3"), "Open Aider (GPT-3.5)" },
        ["<leader>Ab"] = { aider_command_and_insert("AiderBackground"), "Run Aider in Background" },
        ["<leader>Am"] = { aider_command_and_insert("AiderAddModifiedFiles"), "Open Aider and add Git Modified Files to Chat" },
        ["<leader>Ao"] = { aider_command_and_insert("AiderOpen"), "Open Aider" },
    }, { mode = "n" })
else
    -- Set up the actual keybindings when which-key is not available
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
end
