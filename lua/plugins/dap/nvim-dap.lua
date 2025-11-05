local leader = require("keymaps").leader

-- TODO
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- "cmakeseer.nvim",
    -- "LiadOz/nvim-dap-repl-highlights", -- TODO: Configure
  },
  config = function()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })
  end,
  keys = {
    {
      leader("db"),
      function()
        require("dap").toggle_breakpoint()
      end,
      mode = { "v", "n" },
      desc = "Toggle breakpoint",
    },
    {
      leader("dc"),
      function()
        require("dap").continue()
      end,
      mode = { "v", "n" },
      desc = "Continue debug",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      mode = { "v", "n" },
      desc = "Step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      mode = { "v", "n" },
      desc = "Step into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      mode = { "v", "n" },
      desc = "Step out",
    },
    {
      "<F21>", -- <S-F9>
      function()
        -- vim.fn.inputsave()
        -- local condition = vim.fn.input({
        -- 	prompt = "Condition: ",
        -- })
        -- vim.fn.inputrestore()
        -- if condition ~= "" then
        -- 	require("dap").set_breakpoint(condition)
        -- end
        require("persistent-breakpoints.api").set_conditional_breakpoint()
      end,
      mode = { "v", "n" },
      desc = "Set conditional breakpoint",
    },
    {
      "<F57>", -- <M-F9>
      function()
        vim.fn.inputsave()
        local log = vim.fn.input({
          prompt = "Log: ",
        })
        vim.fn.inputrestore()
        if log ~= "" then
          require("dap").set_breakpoint(nil, nil, log)
        end
      end,
      mode = {
        "v",
        "n",
        "i",
      },
      desc = "Set logpoint",
    },
    {
      "<space>dp",
      function()
        require("dap.ui.widgets").preview()
      end,
      mode = { "n", "v" },
      desc = "Preview line execution",
    },
    {
      "<space>df",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      mode = "n",
      desc = "View current frame stack",
    },
    {
      "<space>ds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      mode = "n",
      desc = "View scopes",
    },
  },
}
