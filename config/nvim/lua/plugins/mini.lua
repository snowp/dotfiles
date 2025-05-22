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

      -- Show a notification window when LSP is running
      -- require('mini.notify').setup()

      -- Show buffers in a tab line for easier ]b navigation
      require('mini.tabline').setup()

      -- Improve behavior when :bd is called
      require('mini.bufremove').setup()

      -- Toggle comments, make comments an object
      require('mini.comment').setup()

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

      -- Better start page
      require('mini.starter').setup()

      -- Highlight patterns in the current buffer
      require('mini.hipatterns').setup()
    end
  },
}
