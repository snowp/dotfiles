return {
  'obsidian-nvim/obsidian.nvim',
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- Use vim.fn.expand to properly expand home directory paths
  --   "BufReadPre " .. vim.fn.expand("~/vaults/personal") .. "/*.md",
  --   "BufReadPre " .. vim.fn.expand("~/vaults/work") .. "/*.md",
  --   "BufNewFile " .. vim.fn.expand("~/vaults/personal") .. "/*.md",
  --   "BufNewFile " .. vim.fn.expand("~/vaults/work") .. "/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "preservim/vim-markdown",
    "render-markdown.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "personal",
        path = vim.fn.expand("~/vaults/personal"),
      },
      {
        name = "work",
        path = vim.fn.expand("~/vaults/work"),
      },
    },
    completion = {
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    picker = {
      name = 'snacks.pick'
    },
    ui = {
      enabled = true
    },
  },
}
