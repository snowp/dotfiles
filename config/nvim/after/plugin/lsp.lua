local lsp = require('lsp-zero')

-- Use sane defaults
lsp.preset("recommended")

-- Prompt to install RA if its missing
lsp.ensure_installed({
  "rust_analyzer",
})

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- Use inlay-hints to get inlay hints only on the current line.
local inlay_hints = require('inlay-hints')
inlay_hints.setup(
  {
    only_current_line = true,
  }
)

local lsp_attach = function(client, bufnr)
  inlay_hints.on_attach(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>q', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>lr', '<cmd>:LspRestart<cr>')
  vim.keymap.set('n', '<leader>ls', '<cmd>:LspStart<cr>')

  -- LSP specific telescope views.

  -- Display all symbols in the current workspace in a Telescope view.
  vim.keymap.set("n", "<leader>w", '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', bufopts)
  -- Displays all references of the symbol under the cursor in a Trouble view.
  vim.keymap.set('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', { buffer = true, silent = true })
  -- Displays all lsp diagnostics for the file in a Trouble view.
  vim.keymap.set("n", "<leader>vd", '<cmd>TroubleToggle document_diagnostics<cr>')
  -- Displays all lsp diagnostics for the workspace in a Trouble view.
  vim.keymap.set("n", "<leader>vD", '<cmd>TroubleToggle workspace_diagnostics<cr>')
  -- Close out Trouble
  vim.keymap.set("n", "<leader>x", '<cmd>TroubleToggle<cr>')

  lsp.buffer_autoformat()
end

lsp.on_attach(lsp_attach)

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

-- Skip any LSP that we set up manually below.
lsp.skip_servers = { 'clangd', 'rust-analyzer' }

lsp.setup()

-- Add in copilot etc after lsp-zero has done its first pass of configuring cmp.
cmp.setup({
  completion = {
    keyword_length = 2,
    autocomplete = false,

  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',  keyword_length = 3 },
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',  -- show symbol + name annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    })
  }
})

local function cargo_features(client)
  local path = client.workspace_folders[1].name
  if path == "/Users/snow/src/loop-api" then
    client.config.settings["rust-analyzer"].cargo.features = { "docker-tests" }
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
end

-- -- Add in extra flags for RA to work right. Note that we need to specify on_attach again otherwise it gets overwritten.
local rust_tools = require('rust-tools')

rust_tools.setup({
  tools = {
    on_initialized = function()
      require("inlay-hints").set_all()
    end,
    inlay_hints = {
      auto = false,
    },
  },
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
  server = {
    on_attach = function(client, bufnr)
      lsp_attach(client, bufnr)

      cargo_features(client)

      -- Replace the default LSP ones with the improved rust-tools versions.
      vim.keymap.set("n", "<leader>q", rust_tools.hover_actions.hover_actions, { noremap = true, buffer = bufnr })
      vim.keymap.set("n", "<leader>a", rust_tools.code_action_group.code_action_group, { noremap = true, buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          -- For some repos proc macros slow things down so much
          -- enable = false,
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        cargo = {
          extraEnv = vim.env.PATH,
        }
      }
    }
  }
})

require('lspconfig').clangd.setup({
  on_attach = lsp_attach,
  filetypes = { 'c', 'cpp', 'cc' }
})

require('lspconfig').pest_ls.setup({
})

require('lspconfig').lua_ls.setup({
  on_attach = lsp_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- Configure the diagnostic look and feel.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- vim.cmd("autocmd BufWritePre <buffer> toml !taplo fmt %")
