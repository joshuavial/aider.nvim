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

The Aider Plugin for Neovim provides the `OpenAider` function, which you can call to open a terminal window with the Aider command. The `OpenAider` function accepts the following arguments:

- `command`: The full aider command to use - defaults to `aider`
- `window`: The window style to use 'vsplit' (default), 'hsplit' or 'float'

Note: When Aider opens, it will automatically add all open buffers to the command.

## Working with Buffers in Vim

If you're not familiar with buffers in Vim, here are some tips:

- Use `:ls` or `:buffers` to see all open buffers.
- Use `:b <number>` or `:buffer <number>` to switch to a specific buffer. Replace `<number>` with the buffer number.
- Use `:bd` or `:bdelete` to close the current buffer.
- Use `:bd <number>` or `:bdelete <number>` to close a specific buffer. Replace `<number>` with the buffer number.
- Use `:bufdo bd` to close all buffers.

Before using the `OpenAider` function, you need to require the `aider` module in your configuration file. Add the following line to your `.vimrc` or `init.vim`:

```vim
lua require('aider')
```

Here are some examples of how to use the `OpenAider` function:

```vim
:lua require('aider').OpenAider() 
:lua require('aider').OpenAider("aider", "float") 
:lua require('aider').OpenAider("AIDER_NO_AUTO_COMMITS=1 aider -3" )
```

You can also set keybindings for the `OpenAider` function in Lua. Here's an example:

```lua
-- set a keybinding for the OpenAider function
vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua require("aider").OpenAider()<cr>', {noremap = true, silent = true})
```

In this example, pressing `<leader>oa` in normal mode will call the `OpenAider` function.

Run `aider --help` to see all the options you can pass to the cli.

The plugin provides the following keybindings:

- `<leader><Space><Space>` to open a terminal window with the Aider defaults (gpt-4).
- `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model for chat.

# NOTE

if you resize a split the nvim buffer can truncate the text output, chatGPT tells me there isn't an easy work around for this. Feel free to make a PR if you think it's easy to solve without rearchitecting and using tmux or something similar.
