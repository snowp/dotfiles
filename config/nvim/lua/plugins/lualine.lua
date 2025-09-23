return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            'filename',
            function()
              return require('lsp-progress').progress()
            end
          },
          lualine_x = {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              for _, client in ipairs(clients) do
                if client.name == "rust-analyzer" then
                  local workspace_check = client.settings["rust-analyzer"].check.workspace
                  if workspace_check == nil or workspace_check then
                    return "[W]"
                  else
                    return "[C]"
                  end
                end
              end

              return ""
            end,

            'filetype'
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      })

      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end
  },
}
