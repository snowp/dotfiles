return {
  -- mini.nvim: A collection of small, focused plugins
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better a/i text objects
      require('mini.ai').setup()

      -- Utility functions for dealing with surrounding text (brackets, etc)
      require('mini.surround').setup()
      require('mini.operators').setup()

      -- Navigate with brackets
      require('mini.bracketed').setup()

      -- Show buffers in a tab line for easier ]b navigation
      require('mini.tabline').setup()

      -- Improve behavior when :bd is called
      require('mini.bufremove').setup()

      -- Toggle comments, make comments an object
      require('mini.comment').setup()

      -- Snippets. Using this mostly because it provides a simple way to immediately
      -- accept a snippet based on the prefix vs having to go via the blink.cmp menu.
      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup({
        snippets = {
          -- Load custom file with global snippets first (adjust for Windows)
          gen_loader.from_file('~/.config/nvim/snippets/global.json'),

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang(),
        },
        mappings = {
          -- Expand snippet at cursor position. Created globally in Insert mode.
          expand = '<C-w>',
        },
      })

      -- Move lines and blocks of text around
      require('mini.move').setup(
        {
          -- It would be nice to use something like ALT-hjkl but this conflicts with Aerospace
          -- and using CTRL conflicts with tmux pane management.
          mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<leader>mh',
            right = '<leader>ml',
            down = '<leader>mj',
            up = '<leader>mk',

            -- Move current line in Normal mode
            line_left = '<leader>mh',
            line_right = '<leader>ml',
            line_down = '<leader>mj',
            line_up = '<leader>mk',
          },
        }
      )

      require('mini.pairs').setup()

      -- Avoid annoying autoclose behavior with Rust lifetimes.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        group = vim.api.nvim_create_augroup("Rust_disable_single_quote", { clear = true }),
        callback = function()
          require('mini.pairs').unmap("i", "'", "''")
        end,
        desc = "Disable single quote Rust",
      })

      -- Highlight patterns in the current buffer
      require('mini.hipatterns').setup()
    end
  },
}
