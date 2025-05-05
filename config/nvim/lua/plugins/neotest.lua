return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mrcjkb/rustaceanvim',
      'williamboman/mason.nvim',
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require('rustaceanvim.neotest')
        },
      })
      vim.keymap.set("n", "<leader>vtn", "<cmd>Neotest run<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>vts",
        function() require("neotest").run.stop() end,
        { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>vtf",
        function() require('neotest').run.run(vim.fn.expand('%')) end,
        { noremap = true, silent = true })
    end
  }
}
