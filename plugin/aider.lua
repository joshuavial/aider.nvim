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

local function run_aider()
    vim.fn.termopen('aider', {on_exit = 'OnExit'})
end

function OpenAider(window_type)
    window_type = window_type or 'vsplit'
    open_window(window_type)
    run_aider()
end

function OnExit(job_id, data, event)
    api.nvim_win_close(0, true)
end

vim.g.mapleader = vim.g.mapleader or ' '
api.nvim_set_keymap('n', vim.g.mapleader..' ', ':lua OpenAider()<CR>', {noremap = true})
