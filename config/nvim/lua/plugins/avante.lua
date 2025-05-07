return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy', -- Load the plugin lazily for better startup performance
    version = false,    -- Avoid using "*" to prevent unexpected updates; pin to a specific version if needed
    opts = {
      provider = 'copilot',
      copilot = {
        model = "claude-3.7-sonnet"
      },
      file_selector = {
        provider = "snacks"
      },
      selector = {
        provider = "snacks"
      }
    },
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- Syntax highlighting and parsing
      'stevearc/dressing.nvim',          -- UI enhancements for input and select
      'nvim-lua/plenary.nvim',           -- Utility functions for Lua
      'MunifTanjim/nui.nvim',            -- UI components for Neovim
      --- The below dependencies are optional
      'echasnovski/mini.icons',
      'zbirenbaum/copilot.lua', -- Optional: Support for Copilot provider
      {
        -- Support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy', -- Load lazily for better performance
        opts = {
          -- Recommended settings for img-clip.nvim
          default = {
            embed_image_as_base64 = false, -- Disable embedding images as base64
            prompt_for_file_name = false,  -- Disable file name prompts
            drag_and_drop = {
              insert_mode = true,          -- Enable drag-and-drop in insert mode
            },
            -- Required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Render Markdown files with proper setup
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  }
}
