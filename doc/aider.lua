return {
  "jtfogarty/aider.nvim",
  config = function()
    require('aider').setup({
      -- Configuration options
      auto_manage_context = true,
      default_bindings = true,
      -- You can also set the model to use
      -- model = "claude 3.5", -- or "gpt-3.5-turbo" or any other available model
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
      -- ... (paste the function from the README here)
    end
    vim.api.nvim_set_keymap('n', '<leader>ch', '<cmd>lua close_hidden_buffers()<cr>', {noremap = true, silent = true})
  end,
}
