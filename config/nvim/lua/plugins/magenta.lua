return {
  {
    "dlants/magenta.nvim",
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    opts = {
      picker = "snacks",
      profiles = {
        {
          name = "copilot-claude",
          provider = "copilot",
          model = "claude-3.7-sonnet", -- or "gpt-4.1"
          fastModel = "o3-mini",
        },
        {
          name = "copilot-gpt",
          provider = "copilot",
          model = "gpt-4.1", -- or "gpt-4.1"
          fastModel = "gpt-4.1",
        }
      }
    },
  }
}
