# Aider Plugin for Neovim

This is a plugin for Neovim that allows you to open a terminal window inside Neovim and run the Aider command. The Aider command is part of the [Aider project](https://github.com/paul-gauthier/aider).

## Installation

To install the Aider Plugin for Neovim, clone the repository into your Neovim configuration directory:

```bash
git clone https://github.com/joshuavial/aider.nvim ~/.config/nvim/plugged/
```

Then, add the following line to your Neovim configuration file:

```vim
Plug 'joshuavial/aider.nvim'
```

Finally, run the following command in Neovim to install the plugin:

```vim
:PlugInstall
```

## Usage

Press `<leader><Space><Space>` to open a terminal window with the Aider command.

Press `<leader><Space>3` to open a terminal window with the Aider command using the gpt-3.5-turbo-16k model.
