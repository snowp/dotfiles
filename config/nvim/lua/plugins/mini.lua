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

      -- Automatically insert pairs of characters
      require('mini.pairs').setup(
        {
          -- Exclude ' as it messes with Rust lifetime syntax
          -- Exclude ` as it messes with multiline quoted strings in .md etc.
          mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

            [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
            [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
            ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
          },
        }
      )

      -- Move lines and blocks of text around
      require('mini.move').setup()

      -- Highlight patterns in the current buffer
      require('mini.hipatterns').setup()

      -- Align text interactively
      -- I'm not smart enough to grok this one
      -- require('mini.align').setup()

      -- Show a clue when you're typing out a command
      local miniclue = require('mini.clue')
      miniclue.setup(
        {
          triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },
          },
          clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
          },
        })
    end
  },
}
