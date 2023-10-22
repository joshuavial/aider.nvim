# Changelog

All notable changes to this project will be documented in this file.

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
