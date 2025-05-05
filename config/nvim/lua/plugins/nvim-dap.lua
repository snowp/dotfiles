return {
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  --   config = function()
  --     require('dapui').setup()
  --
  --     -- Automatically open and close the DAP UI when debugging
  --     local dap, dapui = require("dap"), require("dapui")
  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end
  --   end
  -- }
  {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view" },
    config = function()
    end
  }
}
