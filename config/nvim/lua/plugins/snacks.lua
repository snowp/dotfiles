---@module "snacks"

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type snacks.Config
    opts = {
      bigfile = {},
      notifier = {
        timeout = 3000,
      },
      indent = {},
      animate = {},
      quickfile = {},
      statuscolumn = {},
      picker = {
        hidden = true,
      },
      input = {},
      words = {},
      styles = {
        notification = {
          wo = {} -- Wrap notifications
        }
      },
    },
    keys = {
      { "<leader>un",  function() Snacks.notifier.hide() end,               desc = "Dismiss All Notifications" },
      { "<leader>bd",  function() Snacks.bufdelete() end,                   desc = "Delete Buffer" },
      { "<leader>gg",  function() Snacks.lazygit() end,                     desc = "Lazygit" },
      { "<leader>gb",  function() Snacks.git.blame_line() end,              desc = "Git Blame Line" },
      { "<leader>gB",  function() Snacks.gitbrowse() end,                   desc = "Git Browse" },
      { "<leader>gf",  function() Snacks.lazygit.log_file() end,            desc = "Lazygit Current File History" },
      { "<leader>gl",  function() Snacks.lazygit.log() end,                 desc = "Lazygit Log (cwd)" },
      { "<leader>cR",  function() Snacks.rename() end,                      desc = "Rename File" },
      { "<c-/>",       function() Snacks.terminal() end,                    desc = "Toggle Terminal" },
      { "<c-_>",       function() Snacks.terminal() end,                    desc = "which_key_ignore" },
      { "]]",          function() Snacks.words.jump(vim.v.count1) end,      desc = "Next Reference" },
      { "[[",          function() Snacks.words.jump(-vim.v.count1) end,     desc = "Prev Reference" },
      { "<leader>tf",  function() Snacks.picker.files() end },
      { "<leader>tt",  function() Snacks.picker.smart() end },
      { "<leader>tm",  function() Snacks.picker.marks() end },
      { "<leader>tgf", function() Snacks.picker.git_files() end },
      { "<leader>tgs", function() Snacks.picker.git_stash() end },
      { "<leader>tl",  function() Snacks.picker.grep() end },
      { "<leader>tr",  function() Snacks.picker.resume() end },
      { "<leader>tc",  function() Snacks.picker.colorschemes() end },
      { "<leader>tb",  function() Snacks.picker.buffers() end },
      { "<leader>tw",  function() Snacks.picker.lsp_workspace_symbols() end },
      { "<leader>ts",  function() Snacks.picker.lsp_symbols() end },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },

      { "<leader>td",  function() Snacks.picker.diagnostics() end },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },     { "gd",          function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gD",          function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
      { "gR",          function() Snacks.picker.lsp_references() end,       nowait = true,                        desc = "References" },
      { "gI",          function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gy",          function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
            "<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  }
}
