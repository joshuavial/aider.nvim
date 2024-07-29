local helpers = require("helpers")
local M = {}

M.aider_buf = nil
M.debug = false

local function is_valid_buffer(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  -- Ignore special buffers and directories
  if
      buftype ~= ""
      or filetype == "NvimTree"
      or filetype == "neo-tree"
      or bufname:match("^term://")
      or not vim.fn.filereadable(bufname)
      or vim.fn.isdirectory(bufname) == 1
  then
    return false
  end

  return true
end

local function log(message)
  if M.debug then
    print(string.format("[Aider Log] %s", message))
  end
end

function M.AiderBackground(args, message)
  log("AiderBackground called with args: " .. (args or "nil") .. ", message: " .. (message or "nil"))
  helpers.showProcessingCue()
  local command = helpers.build_background_command(args, message)
  local handle = vim.loop.spawn("bash", {
    args = { "-c", command },
  }, NotifyOnExit)

  vim.notify("Aider started " .. (args or ""))
end

local function OnExit(job_id, exit_code, event_type)
  vim.schedule(function()
    if M.aider_buf and vim.api.nvim_buf_is_valid(M.aider_buf) then
      vim.api.nvim_buf_set_option(M.aider_buf, "modifiable", true)
      local message
      if exit_code == 0 then
        message = "Aider process completed successfully."
      else
        message = "Aider process exited with code: " .. exit_code
      end
      vim.api.nvim_buf_set_lines(M.aider_buf, -1, -1, false, { "", message })
      vim.api.nvim_buf_set_option(M.aider_buf, "modifiable", false)
    end
    log("Aider process exited with code: " .. exit_code)
  end)
end

function M.AiderOpen(args, window_type)
  log("AiderOpen called with args: " .. (args or "nil") .. ", window_type: " .. (window_type or "nil"))
  window_type = window_type or "vsplit"
  if M.aider_buf and vim.api.nvim_buf_is_valid(M.aider_buf) then
    log("Existing aider buffer found, opening in new window")
    helpers.open_buffer_in_new_window(window_type, M.aider_buf)
  else
    log("No existing aider buffer, creating new one")
    local command = "aider " .. (args or "")
    log("Opening window with type: " .. window_type)
    helpers.open_window(window_type)
    log("Adding buffers to command")
    command = helpers.add_buffers_to_command(command, is_valid_buffer)
    log("Final command: " .. command)
    log("Opening terminal with command")
    M.aider_buf = vim.api.nvim_get_current_buf()
    M.aider_job_id = vim.fn.termopen(command, { on_exit = OnExit })
    log("Terminal opened with job ID: " .. M.aider_job_id)
    log("Set aider_buf to: " .. M.aider_buf)
    vim.api.nvim_buf_set_option(M.aider_buf, "bufhidden", "hide")
  end
  log("AiderOpen completed")
  log("Final aider_buf: " .. (M.aider_buf or "nil"))
end

function M.AiderOnBufferOpen(bufnr)
  if not vim.g.aider_buffer_sync or vim.g.aider_buffer_sync == 0 then
    return
  end
  bufnr = tonumber(bufnr)
  if not is_valid_buffer(bufnr) then
    return
  end
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local relative_filename = vim.fn.fnamemodify(bufname, ":~:.")
  if M.aider_buf and vim.api.nvim_buf_is_valid(M.aider_buf) then
    local line_to_add = "/add " .. relative_filename
    vim.fn.chansend(M.aider_job_id, line_to_add .. "\n")
  end
end

function M.AiderOnBufferClose(bufnr)
  if not vim.g.aider_buffer_sync or vim.g.aider_buffer_sync == 0 then
    return
  end
  bufnr = tonumber(bufnr)
  if not is_valid_buffer(bufnr) then
    return
  end
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local relative_filename = vim.fn.fnamemodify(bufname, ":~:.")
  if M.aider_buf and vim.api.nvim_buf_is_valid(M.aider_buf) then
    local line_to_drop = "/drop " .. relative_filename
    vim.fn.chansend(M.aider_job_id, line_to_drop .. "\n")
  end
end

local function create_commands()
  log("Creating user commands")
  vim.api.nvim_create_user_command("AiderOpen", function(opts)
    log("AiderOpen command called with args: " .. (opts.args or "nil"))
    M.AiderOpen(opts.args)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("AiderBackground", function(opts)
    log("AiderBackground command called with args: " .. (opts.args or "nil"))
    M.AiderBackground(opts.args)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("AiderAddModifiedFiles", function()
    log("AiderAddModifiedFiles command called")
    M.AiderAddModifiedFiles()
  end, {})
  log("User commands created")
end

function M.AiderAddModifiedFiles()
  log("AiderAddModifiedFiles called")
  if M.aider_buf and vim.api.nvim_buf_is_valid(M.aider_buf) then
    local modified_files = helpers.get_git_modified_files()
    for _, file in ipairs(modified_files) do
      local line_to_add = "/add " .. file
      vim.fn.chansend(M.aider_job_id, line_to_add .. "\n")
    end
    vim.notify("Added " .. #modified_files .. " modified files to Aider chat")
  else
    vim.notify("Aider chat is not open", vim.log.levels.WARN)
  end
end

function M.setup(config)
  M.config = config or {}
  M.config.auto_manage_context = M.config.auto_manage_context or true
  M.config.default_bindings = M.config.default_bindings or true
  M.debug = M.config.debug or false

  vim.g.aider_buffer_sync = M.config.auto_manage_context

  if M.config.auto_manage_context then
    vim.api.nvim_create_autocmd("BufReadPost", {
      callback = function(ev)
        M.AiderOnBufferOpen(ev.buf)
      end,
    })
    vim.api.nvim_create_autocmd("BufDelete", {
      callback = function(ev)
        M.AiderOnBufferClose(ev.buf)
      end,
    })
  end

  create_commands()
  _G.aider_background_status = "idle"

  if M.config.default_bindings then
    require("keybindings")
  end

  log("Aider setup completed with debug mode: " .. tostring(M.debug))
end

return M
