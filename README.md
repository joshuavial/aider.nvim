# Aider Plugin for Neovim

This is a simple plugin for Neovim that allows you to open a terminal window inside Neovim and run [Aider](https://github.com/paul-gauthier/aider). I wrote it as an experiment in using Aider which is by far the best AI coding assistant I've seen, and now just a few keystrokes away in vim.

## Installation

You can install the Aider Plugin for Neovim using various package managers. Here are the instructions for some common ones:

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'joshuavial/aider.nvim'
```

Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'joshuavial/aider.nvim'
```

Using [dein](https://github.com/Shougo/dein.vim)

```vim
call dein#add('joshuavial/aider.nvim')
```

## Usage

The Aider Plugin for Neovim provides the `AiderOpen` and `AiderBackground` lua functions. 

The `AiderOpen` function opens a terminal window with the Aider command. It accepts the following arguments:
- `args`: The command line arguments to pass to `aider` - defaults to ""
- `window_type`: The window style to use 'vsplit' (default), 'hsplit' or 'editor'

NOTE: if an Aider job is already running calling AiderOpen will reattach to it, even if it is called with different flags

The `AiderBackground` function runs the Aider command in the background. It accepts the following arguments:
- `args`: The command line arguments to pass to `aider` - defaults to ""
- `message`: The message to pass to the Aider command - defaults to "Complete as many todo items as you can and remove the comment for any item you complete."

When Aider opens (through either function), it will automatically add all open buffers to both commands. If you are going to use this plugin you will want to actively manage open buffers with commands like `:ls` and `:bd`.

Here are some examples of how to use the `AiderOpen` and `AiderBackground` functions:

```vim
:lua AiderOpen() 
:lua AiderOpen("-3", "hsplit") 
:lua AiderOpen("AIDER_NO_AUTO_COMMITS=1 aider -3", "editor")
:lua AiderBackground()
:lua AiderBackground("-3")
:lua AiderBackground("AIDER_NO_AUTO_COMMITS=1 aider -3")
```

You can also set keybindings for the `AiderOpen` and `AiderBackground` functions in Lua. Here's an example:

```lua
-- set a keybinding for the AiderOpen function
vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua AiderOpen()<cr>', {noremap = true, silent = true})
-- set a keybinding for the AiderBackground function
vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>lua AiderBackground()<cr>', {noremap = true, silent = true})
```

In this example, pressing `<leader>oa` in normal mode will call the `AiderOpen` function, and `<leader>ob` will call the `AiderBackground` function.

Run `aider --help` to see all the options you can pass to the cli.

The plugin provides the following default keybindings:

- `<leader><Space><Space>` to open a terminal window with the Aider defaults (gpt-4).
- `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model for chat.
- `<leader><space>b` to run the Aider command in the background with the defaults.
- `<leader><space>b3` to run the Aider command in the background using the gpt-3.5-turbo-16k model for chat.

## Setup

The Aider Plugin for Neovim provides a `setup` function that you can use to configure the plugin. This function accepts a table with the following keys:

- `auto_manage_context`: A boolean value that determines whether the plugin should automatically manage the context. If set to `true`, the plugin will automatically add and remove buffers from the context as they are opened and closed. Defaults to `true`.
- `default_bindings`: A boolean value that determines whether the plugin should use the default keybindings. If set to `true`, the plugin will require the keybindings file and set the default keybindings. Defaults to `true`.
- `ignore_buffers`: A list of matching patterns for buffer names that will be ignored. Defaults to `{'^term:', 'NeogitConsole', 'NvimTree_', 'neo-tree filesystem'}`.

Here is an example of how to use the `setup` function:

```lua
require('aider').setup({
  auto_manage_context = false,
  default_bindings = false,
  ignore_buffers = {},
})
```

In this example, the `setup` function is called with a table that sets `auto_manage_context` to `false` and `default_bindings` to `false`. This means that the plugin will not automatically manage the context and will not use the default keybindings.

## aider_background_status

The plugin exposes a global variable called `aider_background_status` that you can use to check the status of the Aider background process. Here is a snippet which will create a A that will change colours based on whether the background process is running or not.

```lua
lualine_x = {{
    function() 
      return 'A'
    end,
    color = { fg = '#8FBCBB' }, -- green
    cond = function() 
      return _G.aider_background_status == 'idle'
    end
  },
  {
    function() 
      return 'A'
    end,
    color = { fg = '#BF616A' }, -- red
    cond = function() 
      return _G.aider_background_status == 'working'
    end
  }
}
```

## Reloading buffers

Because the AiderOnBufferOpen command is bound to BufReadPost it will fire whenever a buffer is reloaded if you just use a `:e!`. The ReloadBuffer function below will prevent a file from being added to aider every time it's openeed.

```lua
function ReloadBuffer()
  local temp_sync_value = vim.g.aider_buffer_sync                            
  vim.g.aider_buffer_sync = 0                                                
  vim.api.nvim_exec2('e!', {output = false})
  vim.g.aider_buffer_sync = temp_sync_value
end
```

To use this function, simply call `:lua ReloadBuffer()` (or bind it to your favourite shortcut). This will refresh the current buffer and display any changes made by Aider.

## Tips for Working with Buffers in Vim

If you're not familiar with buffers in Vim, here are some tips:

- Use `:ls` or `:buffers` to see all open buffers.
- Use `:b <number>` or `:buffer <number>` to switch to a specific buffer. Replace `<number>` with the buffer number.
- Use `:bd` or `:bdelete` to close the current buffer.
- Use `:bd <number>` or `:bdelete <number>` to close a specific buffer. Replace `<number>` with the buffer number.
- Use `:bufdo bd` to close all buffers.

This helper function may be useful for closing all buffers that are hidden

```lua
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
```

## NOTE

if you resize a split the nvim buffer can truncate the text output, chatGPT tells me there isn't an easy work around for this. Feel free to make a PR if you think it's easy to solve without rearchitecting and using tmux or something similar.

