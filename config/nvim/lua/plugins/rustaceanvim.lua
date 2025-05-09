-- rustaceanvim provides some nice utilities for Rust development beyond what the default LSP
-- provides.
return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("RustFormatting", {})

      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            local opts = { silent = false, buffer = bufnr }

            -- Avoid conflicts with other LSP clients. Ideally we wouldn't run into this but its easier than trying to figure out
            -- why the LSP client is attaching multiple times.
            vim.b.lsp_attached = true

            -- Replace the default LSP ones with the improved rustaceanvim versions.
            vim.keymap.set("n", "<leader>q", function() vim.cmd.RustLsp { 'hover', 'actions' } end, opts)
            vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, opts)
            vim.keymap.set("n", "<leader>vt", function() vim.cmd.RustLsp('testables') end, opts)
            vim.keymap.set("n", "<leader>ve", function() vim.cmd.RustLsp('explainError') end, opts)
            vim.keymap.set("n", "<leader>vr", function() vim.cmd.RustLsp('relatedDiagnostics') end, opts)
            vim.keymap.set("n", "<leader>vc", function() vim.cmd.RustLsp('openCargo') end, opts)

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })

            vim.keymap.set("n", "<F2>", function()
              require('dap').toggle_breakpoint()
            end, { buffer = 0 })

            vim.keymap.set("n", "<F6>", function()
              require('dap').step_over()
            end, { buffer = 0 })

            vim.keymap.set("n", "<F7>", function()
              require('dap').step_into()
            end, { buffer = 0 })

            vim.keymap.set("n", "<F8>", function()
              require('dap').step_out()
            end, { buffer = 0 })
          end,
          settings = {
            ["rust-analyzer"] = {
              check = {
                -- workspace = false,
              },
              files = {
                excludeDirs = {
                  "target",
                  "node_modules",
                  ".git",
                  ".nx",
                  ".verdaccio",
                  ".idea",
                  ".sqlx",
                  "bazel-bin",
                  "bazel-out",
                  "bazel-testlogs",
                  "bazel-capture-sdk",
                  "Capture.xcodeproj",
                  "tmp",
                  "gradle"
                },
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
