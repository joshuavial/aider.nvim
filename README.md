# Aider Plugin for Neovim

This is a simple plugin for Neovim that allows you to open a terminal window inside Neovim and run the [Aider](https://github.com/paul-gauthier/aider). I wrote it as an experiment in using Aider and it is by far the best AI coding assistant I've seen.

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

```viml
call dein#add('joshuavial/aider.nvim')
```

## Usage

The Aider Plugin for Neovim provides the `OpenAider` function, which you can call to open a terminal window with the Aider command. The `OpenAider` function accepts the following arguments:

- `command`: The full aider command to use - defaults to `aider`
- `window`: The window style to use 'vsplit' (default), 'hsplit' or 'float'

Here are some examples of how to use the `OpenAider` function:

```vim
:lua require('aider').OpenAider() 
:lua require('aider').OpenAider("aider", "float") 
:lua require('aider').OpenAider("AIDER_NO_AUTO_COMMITS=1 aider -3" )
```

You can also set keybindings for the `OpenAider` function in Lua. Here's an example:

```lua
-- First, require the plugin
local aider = require('aider')

-- Then, set a keybinding for the OpenAider function
vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua require("aider").OpenAider()<cr>', {noremap = true, silent = true})
```

In this example, pressing `<leader>oa` in normal mode will call the `OpenAider` function.

Run `aider --help` to see all the options you can pass to the cli.

The plugin provides the following keybindings:

- `<leader><Space><Space>` to open a terminal window with the Aider defaults (gpt-4).
- `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model for chat.
