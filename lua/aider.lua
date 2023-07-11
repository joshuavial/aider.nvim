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
    vim.fn.termopen(command, {on_exit = 'OnExit'})
end

vim.g.mapleader = vim.g.mapleader or ' '
api.nvim_set_keymap('n', vim.g.mapleader..' ', ':lua M.OpenAider()<CR>', {noremap = true})
api.nvim_set_keymap('n', vim.g.mapleader..' 3', ':lua M.OpenAider("aider -3 --model gpt-3.5-turbo-16k")<CR>', {noremap = true})

return M
