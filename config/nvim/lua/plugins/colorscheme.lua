return {
  -- Only include the colorscheme we're actually using
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000, -- Make sure it loads first
  },
}