local api = vim.api

local function open_window(window_type)
    local buf = api.nvim_create_buf(false, true)
    if window_type == 'vsplit' then
        vim.cmd('vnew')
    elseif window_type == 'hsplit' then
        vim.cmd('new')
    else
        local width = api.nvim_win_get_width(0) - 10
        local height = api.nvim_win_get_height(0) - 10
        local row = 2
        local col = 2
        local win = api.nvim_open_win(buf, true, {relative = 'editor', width = width, height = height, row = row, col = col})
        api.nvim_set_current_win(win)
    end
    vim.bo[buf].buftype = 'nofile'
end

function OnExit(job_id, data, event)
    api.nvim_win_close(0, true)
end

local M = {}

function M.OpenAider(command, window_type)
    command = command or 'aider'
    window_type = window_type or 'vsplit'
    open_window(window_type)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local bufname = vim.api.nvim_buf_get_name(buf)
            if not bufname:match('^term:') then
                command = command .. " " .. bufname
            end
        end
    end
    vim.fn.termopen(command, {on_exit = 'OnExit'})
end

vim.g.mapleader = vim.g.mapleader or ' '
api.nvim_set_keymap('n', '<leader>  ', ':lua require("aider").OpenAider()<CR>', {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader> 3', ':lua require("aider").OpenAider("aider -3")<CR>', {noremap = true, silent = true})

return M
