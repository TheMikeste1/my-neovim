return {
  "rcarriga/nvim-dap-ui",
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    -- dap.listeners.before.event_terminated.dapui_config = dapui.close
    -- dap.listeners.before.event_exited.dapui_config = dapui.close
  end,
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  event = "VeryLazy",
}
