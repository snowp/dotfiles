return {
  {
    "dlants/magenta.nvim",
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    opts = {
      profiles = {
        {
          name = "copilot",
          provider = "copilot",
          model = "claude-3.7-sonnet" -- or "gpt-4.1"
        }
      }
    },
  }
}
