-- rustaceanvim provides some nice utilities for Rust development beyond what the default LSP
-- provides.
return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    ft = { 'rust' },
    config = function()
      local augroup = vim.api.nvim_create_augroup("RustFormatting", {})

      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local opts = { silent = false, buffer = bufnr }

            -- Replace the default LSP ones with the improved rustaceannvim versions.
            vim.keymap.set("n", "<leader>q", function() vim.cmd.RustLsp { 'hover', 'actions' } end, opts)
            vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, opts)
            vim.keymap.set("n", "<leader>vT", function() vim.cmd.RustLsp('testables') end, opts)
            vim.keymap.set("n", "<leader>vE", function() vim.cmd.RustLsp('explainError') end, opts)
            vim.keymap.set("n", "<leader>vC", function() vim.cmd.RustLsp('openCargo') end, opts)

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end,
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { "target", "node_modules", ".git", ".nx", ".verdaccio" },
              },
              rustfmt = {
                extraArgs = { "+nightly" },
              },
            }
          }
        }
      }
    end,
  }
}
