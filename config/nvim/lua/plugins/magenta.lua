return {
  {
    "dlants/magenta.nvim",
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    opts = {
      picker = "snacks",
      profiles = {
        {
          name = "copilot-gpt-4",
          provider = "copilot",
          model = "gpt-4.1",
          fastModel = "gpt-4o-mini",
        },
        {
          name = "copilot-gpt",
          provider = "copilot",
          model = "gpt-4.1", -- or "gpt-4.1"
          fastModel = "gpt-4.1",
        }
      }
    },
    setup = function()
    end
  }
}
