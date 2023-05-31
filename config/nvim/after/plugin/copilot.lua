-- require("copilot").setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })
--
vim.cmd("imap <silent><script><expr> <C-J> copilot#Accept('\\<CR>')")
vim.cmd("let g:copilot_no_tab_map = v:true")
