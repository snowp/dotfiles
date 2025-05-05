return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy', -- Load the plugin lazily for better startup performance
    version = false,    -- Avoid using "*" to prevent unexpected updates; pin to a specific version if needed
    opts = {            -- Add any plugin-specific options here
      -- Example configuration for the OpenAI provider
      provider = 'copilot',
      openai = {
        endpoint = 'https://api.openai.com/v1', -- API endpoint for OpenAI
        model = 'gpt-4o',                       -- Specify the desired model (e.g., gpt-4o, gpt-4, etc.)
        timeout = 30000,                        -- Timeout in milliseconds; increase for reasoning models
        temperature = 0,                        -- Set temperature for deterministic responses
        max_tokens = 8192,                      -- Maximum tokens for the response; adjust for reasoning models
        -- reasoning_effort = 'medium', -- Optional: low|medium|high for reasoning models
      },
    },
    -- Build the plugin from source using `make`
    build = 'make',
    -- Uncomment and modify the below line for Windows builds
    -- build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- Syntax highlighting and parsing
      'stevearc/dressing.nvim',          -- UI enhancements for input and select
      'nvim-lua/plenary.nvim',           -- Utility functions for Lua
      'MunifTanjim/nui.nvim',            -- UI components for Neovim
      --- The below dependencies are optional
      'echasnovski/mini.pick',           -- Optional: File selector provider using mini.pick
      'nvim-tree/nvim-web-devicons',     -- Optional: File icons (or use echasnovski/mini.icons)
      'zbirenbaum/copilot.lua',          -- Optional: Support for Copilot provider
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
          file_types = { 'markdown', 'Avante' }, -- Specify file types to render
        },
        ft = { 'markdown', 'Avante' },           -- Load for specified file types
      },
    },
  }
}
