# Changelog

All notable changes to this project will be documented in this file.

## dev - 2025-04-17
- configure border in floating window from @juha-metaplay

## [0.6.0] - 2025-01-08
- set filetype of terminal window to AiderConsole

## [0.5.0] - 2025-01-06
- removed the vim config flag (it's trival for users to add it with a keybinding)
- put deprecation warning for `<leader><space>` keybinding

## [0.4.0] - 2025-01-05

### Fixed
- custom config being ignored (@valentino-sm)

### Added
- Lazy.nvim compatibility (@jondkinney)
- Change default bindings to A prefix (@jondkinney)
- Debug logging system with configurable debug mode(@jondkinney)
- Better handling of special buffers and directories (@jondkinney)
- New config option to customise buffers to ignore (@valentino-sm)

### Removed
- AiderBackground command (`aider --watch-files` replaces functionality)

## [0.3.1] - 2023-10-22

### Fixed
- switched the AiderOnBufferOpen autocmd to BufReadPost from BufOpen to avoid terminal windows

## [0.3.0] - 2023-10-15

NOTE : the function signatures have changed so if you have custom bindings, you will need to update them.

### Added
- setup function to easily toggle features
- auto_manage_context will add and drop files in aider as you open and close buffers
- AiderBackground() (`<leader><space>b`) will run aider in a background task to complete todo comments in the code base
- expose a global aider_background_status variable for easy visual feedback
- closing the Aider split and calling AiderOpen again will reattach to the existing process

## [0.2.1] - 2023-07-18

### Added
- Ignore `NeogitConsole` buffers when opening Aider.

## [0.2] - 2023-07-13

### Added
- Aider now automatically adds all open buffers when it opens.
- Added tips for working with buffers in Vim to the README.md file.

## [0.1] - 2023-07-12

### Added
- Initial release
