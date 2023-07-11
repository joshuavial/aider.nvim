# Aider Plugin for Neovim

This is a plugin for Neovim that allows you to open a terminal window inside Neovim and run the Aider command. The Aider command is part of the [Aider project](https://github.com/paul-gauthier/aider).

## Installation

You can install the Aider Plugin for Neovim using various package managers. Here are the instructions for some of the most common ones:

### vim-plug

1. Add the following line to your Neovim configuration file:

```vim
Plug 'joshuavial/aider.nvim'
```

2. Run the following command in Neovim to install the plugin:

```vim
:PlugInstall
```

### packer.nvim

1. Add the following line to your Neovim configuration file:

```lua
use 'joshuavial/aider.nvim'
```

2. Run the following command in Neovim to install the plugin:

```vim
:PackerInstall
```

## Usage

The Aider Plugin for Neovim provides the `OpenAider` function, which you can call to open a terminal window with the Aider command. The `OpenAider` function accepts the following arguments:

- `model`: The name of the model to use. Default is `gpt-3.5-turbo-16k`.
- `prompt`: The initial prompt to pass to the Aider command. Default is an empty string.

Here are some examples of how to use the `OpenAider` function:

```vim
:OpenAider gpt-3.5-turbo-16k "Hello, Aider!"
:OpenAider gpt-3.5-turbo-16k
:OpenAider
```

You can also use the following keybindings:

- Press `<leader><Space><Space>` to open a terminal window with the Aider command.
- Press `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model.
