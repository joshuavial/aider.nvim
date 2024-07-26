return {
  "jtfogarty/aider.nvim",
  config = function()
    require('aider').setup({
      -- Configuration options
      auto_manage_context = true,
      default_bindings = true,
      -- You can also set the model to use
      -- model = "claude 3.5", -- or "gpt-3.5-turbo" or any other available model
      python_env = "/Users/jefffogarty/.pyenv/versions/3.12.1/bin/python -m env aider" -- Command to start Aider environment
    })

    -- Keybindings
    vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua AiderOpen()<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>lua AiderBackground()<cr>', {noremap = true, silent = true})

    -- ReloadBuffer function
    function _G.ReloadBuffer()
      local temp_sync_value = vim.g.aider_buffer_sync
      vim.g.aider_buffer_sync = 0
      vim.api.nvim_exec2('e!', {output = false})
      vim.g.aider_buffer_sync = temp_sync_value
    end
    vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>lua ReloadBuffer()<cr>', {noremap = true, silent = true})

    -- close_hidden_buffers function
    _G.close_hidden_buffers = function()
      local curr_buf_num = vim.api.nvim_get_current_buf()
      local all_buf_nums = vim.api.nvim_list_bufs()

      for _, buf_num in ipairs(all_buf_nums) do
        if buf_num ~= curr_buf_num and vim.api.nvim_buf_is_valid(buf_num) and vim.api.nvim_buf_is_loaded(buf_num) and vim.fn.bufwinnr(buf_num) == -1 then
          if vim.fn.getbufvar(buf_num, '&buftype') ~= 'terminal' then
            vim.api.nvim_buf_delete(buf_num, { force = true })
          end
        end
      end
    end
    vim.api.nvim_set_keymap('n', '<leader>ch', '<cmd>lua close_hidden_buffers()<cr>', {noremap = true, silent = true})
  end,
}
