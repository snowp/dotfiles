return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy', -- Load the plugin lazily for better startup performance
    version = false,    -- Avoid using "*" to prevent unexpected updates; pin to a specific version if needed
    opts = {
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      provider = 'copilot',
      copilot = {
        model = "claude-3.7-sonnet"
      },
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        temperature = 0,
        max_tokens = 4096,
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
      'ravitemer/mcphub.nvim',
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
