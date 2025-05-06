return {
  -- {
  --   'kristijanhusak/vim-dadbod-ui',
  --   dependencies = {
  --     { 'tpope/vim-dadbod' },
  --     { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  --   },
  --   cmd = {
  --     'DBUI',
  --     'DBUIToggle',
  --     'DBUIAddConnection',
  --     'DBUIFindBuffer',
  --   },
  --   init = function()
  --     vim.g.db_ui_use_nerd_fonts = 1
  --     -- Try to get this from the environment instead of having to hard code it here for all
  --     -- projects. This also would avoid having unnecessary configurations for different projects.
  --     vim.g.dbs = vim.g.dbs or {
  --       clickhouse = "clickhouse://localhost:9001/",
  --       postgres_lapi_sqlx = "postgres://postgres:password@localhost:5437/",
  --       postgres_lapi_test = "postgres://postgres:password@localhost:5432/",
  --     }
  --     vim.keymap.set('n', '<leader>db', ":DBUI<CR>")
  --   end,
  -- }
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup( --[[optional config]])
      vim.keymap.set("n", "<leader>db", "lua require'dbee'.open()")
    end,
  },
}
