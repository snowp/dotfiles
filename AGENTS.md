# Agent Guidelines for Dotfiles Repository

## Project Structure
- **bin/**: Scripts and executable utilities
- **config/**: Application configurations
  - **nvim/**: Neovim configuration
    - **lua/**: Lua modules for Neovim
      - **plugins/**: Individual plugin configurations
    - **snippets/**: Code snippets for various languages
  - **atuin/**: Shell history configuration
  - **skhd/**: Hotkey daemon configuration
- **zsh/**: ZSH configuration files separated by functionality
- **Root files**: Core dotfiles (gitconfig, tmux.conf, zshrc, etc.)

## Commands
- **Testing**: Run tests with appropriate test runners for each language
  - For single tests, use language-specific test filtering options
- **Vim**: Use vim-test plugin commands (`:TestNearest`, `:TestFile`, `:TestSuite`)
- **Building**: Use language-appropriate build commands

## Style Guidelines
- Follow language-specific style conventions
- Use consistent formatting for each file type
- For Lua files: Follow Neovim Lua style conventions
- Maintain consistent organization of plugin files
- **Naming**: Use snake_case for functions, PascalCase for types
- **Imports**: Group imports logically (core, plugins, local)
- **Error Handling**: Use appropriate patterns for each language

## Best Practices
- Keep configuration modular with clear separation of concerns
- Follow idiomatic practices for each language
- Ensure compatibility across different operating systems
- Maintain clean, well-organized structure