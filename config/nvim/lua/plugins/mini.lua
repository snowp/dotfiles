return {
  -- mini.nvim: A collection of small, focused plugins
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better a/i text objects
      require('mini.ai').setup()

      -- Utiliity functions for dealing with surrounding text (brackets, etc)
      require('mini.surround').setup()
      require('mini.operators').setup()

      -- Navigate with brackets
      require('mini.bracketed').setup()

      -- Show a notification window when LSP is running
      require('mini.notify').setup()

      -- Show buffers in a tab line for easier ]b navigation
      require('mini.tabline').setup()

      -- Improve behavior when :bd is called
      require('mini.bufremove').setup()

      -- Toggle comments, make comments an object
      require('mini.comment').setup()

      -- Move lines and blocks of text around
      require('mini.move').setup()

      -- Highlight patterns in the current buffer
      require('mini.hipatterns').setup()
    end
  },
}
