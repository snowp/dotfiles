return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy', -- Load the plugin lazily for better startup performance
    version = false,    -- Avoid using "*" to prevent unexpected updates; pin to a specific version if needed
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
    config = function()
      vim.keymap.set('v', '<leader>aF', ":AvanteEdit fix braces, brackets and parenthesis here<CR>",
        { desc = 'Avante Fix Syntax' })

      vim.keymap.set('v', '<Leader>aP', function()
        local items = {}
        local longest_name = 0
        for i, prompt in ipairs({
          { name = 'Fix brackets',            prompt = 'Fix brackets, braces and parenthesis here' },
          { name = 'Fix indentation',         prompt = 'Fix indentation here' },
          { name = 'Fix trailing whitespace', prompt = 'Fix trailing whitespace here' },
          { name = 'Fix all',                 prompt = 'Fix all issues in the current file' },
        }) do
          table.insert(items, {
            idx = i,
            score = i,
            prompt = prompt.prompt,
            name = prompt.name,
          })
          longest_name = math.max(longest_name, #prompt.name)
        end
        longest_name = longest_name + 2
        return Snacks.picker({
          items = items,
          format = function(item)
            local ret = {}
            ret[#ret + 1] = { ('%-' .. longest_name .. 's'):format(item.name), 'SnacksPickerLabel' }
            ret[#ret + 1] = { item.text, 'SnacksPickerComment' }
            return ret
          end,
          confirm = function(picker, item)
            picker:close()
            -- Restore visual selection and apply AvanteEdit using range
            vim.cmd('normal! gv') -- Re-select the visual area
            vim.cmd((":'<,'>AvanteEdit %s"):format(item.prompt))
          end,
        })
      end)

      require('avante').setup {
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
        providers = {
          copilot = {
            model = "claude-3.7-sonnet"
          },
        },
        file_selector = {
          provider = "snacks"
        },
        selector = {
          provider = "snacks"
        }
      }
    end,
  }
}
