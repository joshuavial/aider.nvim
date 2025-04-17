local config = {}

local function set_config(new_config)
	config = new_config
end

local function open_vsplit_window()
	vim.api.nvim_command("vnew")
end

local function open_hsplit_window()
	vim.api.nvim_command("new")
end

local function open_editor_relative_window()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = vim.api.nvim_get_option_value("columns", {})
	local height = vim.api.nvim_get_option_value("lines", {})

	local float_opts = {
		relative = "editor",
		width = width - 10,
		height = height - 10,
		row = 2,
		col = 2,
	}

	if config.border and config.border.style then
		float_opts.border = config.border.style
	end

	local win = vim.api.nvim_open_win(buf, true, float_opts)

	if config.border and config.border.color then
		vim.api.nvim_set_hl(0, "AiderFloatBorder", { fg = config.border.color, bg = "None" })
		vim.api.nvim_set_option_value("winhl", "FloatBorder:AiderFloatBorder", { win = win })
	end

	vim.api.nvim_set_current_win(win)
end

local function open_window(window_type)
	if window_type == "vsplit" then
		open_vsplit_window()
	elseif window_type == "hsplit" then
		open_hsplit_window()
	else
		open_editor_relative_window()
	end
end

function NotifyOnExit(code, signal)
	vim.schedule(function()
		set_idle_status(true)
		vim.api.nvim_command('echo ""')
		vim.cmd("edit")
		vim.notify("Aider finished with exit code " .. code)
	end)
end


local function add_buffers_to_command(command, is_valid_buffer)
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and is_valid_buffer(buf) then
			local bufname = vim.api.nvim_buf_get_name(buf)
			if vim.fn.filereadable(bufname) == 1 then
				command = command .. " " .. vim.fn.shellescape(bufname)
			end
		end
	end
	return command
end

local function open_buffer_in_new_window(window_type, aider_buf)
	if window_type == "vsplit" then
		vim.api.nvim_command("vsplit | buffer " .. aider_buf)
	elseif window_type == "hsplit" then
		vim.api.nvim_command("split | buffer " .. aider_buf)
	else
		vim.api.nvim_command("buffer " .. aider_buf)
	end
end

local function get_git_modified_files()
	local handle = io.popen("git ls-files --modified --others --exclude-standard")
	local result = handle:read("*a")
	handle:close()
	local files = {}
	for file in result:gmatch("[^\r\n]+") do
		table.insert(files, file)
	end
	return files
end

return {
	open_window = open_window,
	NotifyOnExit = NotifyOnExit,
	add_buffers_to_command = add_buffers_to_command,
	open_buffer_in_new_window = open_buffer_in_new_window,
	get_git_modified_files = get_git_modified_files,
	set_config = set_config,
}
