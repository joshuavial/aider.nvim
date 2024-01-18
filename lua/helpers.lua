local function set_idle_status(isIdle)
  if isIdle then
    _G.aider_background_status = 'idle'
  else
    _G.aider_background_status = 'working'
  end
  vim.cmd('redrawstatus')
end

local function open_vsplit_window()
  vim.api.nvim_command('vnew')
end

local function open_hsplit_window()
  vim.api.nvim_command('new')
end

local function open_editor_relative_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win = vim.api.nvim_open_win(buf, true, {relative = 'editor', width = width - 10, height = height - 10, row = 2, col = 2})
  vim.api.nvim_set_current_win(win)
  vim.bo[buf].buftype = 'nofile'
end

local function open_window(window_type)
  if window_type == 'vsplit' then
    open_vsplit_window()
  elseif window_type == 'hsplit' then
    open_hsplit_window()
  else
    open_editor_relative_window()
  end
end

function NotifyOnExit(code, signal)
  vim.schedule(function()
    set_idle_status(true)
    vim.api.nvim_command('echo ""')
    vim.cmd('edit')
    vim.notify("Aider finished with exit code " .. code)
  end)
end

local function showProcessingCue()
  vim.api.nvim_command('echo "Aider processing ..."')
  set_idle_status(false)
end

local function add_buffers_to_command(command, ignore_buffers)
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      for _, ignore_buf in ipairs(ignore_buffers or {}) do
        if bufname:match(ignore_buf) then
          goto continue
        end
      end
      command = command .. " " .. bufname
    end
    ::continue::
  end
  return command
end

local function build_background_command(args, prompt)
  prompt = prompt or "Complete as many todo items as you can and remove the comment for any item you complete."
  local command = 'aider --msg "' .. prompt .. '" ' .. (args or '')
  command = add_buffers_to_command(command)
  return command
end

function open_buffer_in_new_window(window_type, aider_buf)
  if window_type == 'vsplit' then
    vim.api.nvim_command('vsplit | buffer ' .. aider_buf)
  elseif window_type == 'hsplit' then
    vim.api.nvim_command('split | buffer ' .. aider_buf)
  else
    vim.api.nvim_command('buffer ' .. aider_buf)
  end
end


return {
  open_window = open_window,
  NotifyOnExit = NotifyOnExit,
  showProcessingCue = showProcessingCue,
  add_buffers_to_command = add_buffers_to_command,
  build_background_command = build_background_command,
  open_buffer_in_new_window = open_buffer_in_new_window
}
