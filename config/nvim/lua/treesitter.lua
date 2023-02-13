require('nvim-treesitter.configs').setup {
  ensure_installed = { "help", "lua", "rust", "toml", "swift", "terraform", "yaml", "cpp", "json", "python" },
  sync_install = false,
  auto_install = true,
  -- ident = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- rainbow = {
  --   enable = true,
  --   extended_mode = true,
  --   max_file_lines = nil,
  -- }
}

