# Aider Plugin for Neovim

This is a simple plugin for Neovim that allows you to open a terminal window inside Neovim and run the [Aider](https://github.com/paul-gauthier/aider). I wrote it as an experiment in using Aider and it is by far the best AI coding assistant I've seen.

## Installation

You can install the Aider Plugin for Neovim using various package managers. Here are the instructions for some of the most common ones:


### packer.nvim

1. Add the following line to your Neovim configuration file:

```lua
use 'joshuavial/aider.nvim'
```

2. Run the following command in Neovim to install the plugin:

```vim
:PackerInstall
```

### vim-plug

1. Add the following line to your Neovim configuration file:

```vim
Plug 'joshuavial/aider.nvim'
```

2. Run the following command in Neovim to install the plugin:

```vim
:PlugInstall
```

## Usage

The Aider Plugin for Neovim provides the `OpenAider` function, which you can call to open a terminal window with the Aider command. The `OpenAider` function accepts the following arguments:

- `command`: The full aider command to use - defaults to `aider`
- `window`: The window style to use 'vsplit' (default), 'hsplit' or 'float'

Here are some examples of how to use the `OpenAider` function:

```vim
:lua OpenAider() 
:lua OpenAider("aider", "float") 
:lua OpenAider("AIDER_NO_AUTO_COMMITS=1 aider -3" )
```

The plugin provides the following keybindings:

- Press `<leader><Space><Space>` to open a terminal window with the Aider defaults (gpt-4).
- Press `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model for chat and .
