return {
  -- Selection plugin
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          path_display = {
            "truncate",
          },
        },
        -- Use dropdown instead of the default view for file pickers
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          git_files = {
            theme = "dropdown",
          },
          buffers = {
            theme = "ivy",
          },
        },
        extensions = {
          live_grep_args = {
            theme = "dropdown",
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          }
        },
      })

      require('telescope').load_extension('file_browser')
      require('telescope').load_extension('live_grep_args')

      local builtin = require('telescope.builtin')
      vim.keymap.set("n", "<leader>tgf", builtin.git_files)
      vim.keymap.set("n", "<leader>tgb", builtin.git_branches)
      vim.keymap.set("n", "<leader>tgs", builtin.git_status)
      vim.keymap.set("n", "<leader>tf", builtin.find_files)
      vim.keymap.set("n", "<leader>tl", builtin.live_grep)
      vim.keymap.set("n", "<leader>tr", builtin.resume)
      vim.keymap.set("n", "<leader>ta", require('telescope').extensions.live_grep_args.live_grep_args)
      vim.keymap.set("n", "<leader>tb", builtin.buffers)
      vim.keymap.set("n", "<leader>tc", builtin.current_buffer_fuzzy_find)
      vim.keymap.set("n", "<leader>th", builtin.command_history)
    end
  }
}
