return {
  {
    'rgroli/other.nvim',
    init = function()
      require("other-nvim").setup({
        mappings = {
          -- builtin mappings
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
          "python",
          "react",
          "elixir",
          "clojure",
          -- Navigate from X_test.rs -> X.rs
          {
            pattern = "(.*)_test.rs$",
            target = "%1.rs",
            context = "test"
          },
          -- Navigate from X.rs -> X_test.rs, making sure we avoid mapping X_test.rs to X_test_test.rs.
          {
            pattern = function(file)
              local match = file:match("(.*).rs$")
              if match and not file:match("_test.rs$") then
                return { match, "component" }
              end
              return nil
            end,
            target = "%1_test.rs",
            context = "lib"
          }
        },
        style = {
          -- How the plugin paints its window borders
          -- Allowed values are none, single, double, rounded, solid and shadow
          border = "solid",

          -- Column seperator for the window
          seperator = "|",

          -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
          width = 0.7,

          -- min height in rows.
          -- when more columns are needed this value is extended automatically
          minHeight = 2
        },
      })

      vim.keymap.set("n", "<leader>oo", function()
        require("other-nvim").open()
      end, { desc = "Open other file" })
      vim.keymap.set("n", "<leader>os", function()
        require("other-nvim").openSplit()
      end, { desc = "Open other file in horizontal split" })
      vim.keymap.set("n", "<leader>ov", function()
        require("other-nvim").openVSplit()
      end, { desc = "Open other file in vertical split" })
    end,
  }
}
