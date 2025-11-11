local leader = require("keymaps").leader
local rapid_leader = require("keymaps").rapid_leader

local function get_condition()
  -- TODO: Use highlighting for current language
  vim.fn.inputsave()
  local condition = vim.fn.input({
    prompt = "Condition: ",
  })
  vim.fn.inputrestore()
  if condition == "" then
    return nil
  end
  return condition
end

local function get_hit_condition()
  vim.fn.inputsave()
  local condition = vim.fn.input({
    prompt = "Hit condition: ",
  })
  vim.fn.inputrestore()
  if condition == "" then
    return nil
  end
  return condition
end

local function get_log_message()
  vim.fn.inputsave()
  local message = vim.fn.input({
    prompt = "Log message: ",
  })
  vim.fn.inputrestore()
  if message == "" then
    return nil
  end
  return message
end

local function set_conditional_breakpoint()
  local condition = get_condition()
  if condition ~= nil then
    require("dap").set_breakpoint(condition)
  end
end

local function set_hit_breakpoint()
  local condition = get_hit_condition()
  if condition ~= nil then
    require("dap").set_breakpoint(nil, condition)
  end
end

local function set_logpoint()
  local message = get_log_message()
  if message ~= nil then
    require("dap").set_breakpoint(nil, nil, message)
  end
end

local function set_advanced_breakpoint()
  local condition = get_condition()
  local hit_condition = get_hit_condition()
  local message = get_log_message()
  require("dap").set_breakpoint(condition, hit_condition, message)
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        local python_path = vim.fn.exepath("python")
        python_path = python_path ~= "" and python_path or "python"
        require("dap-python").setup(python_path)

        require("which-key").add({
          { leader("d"), group = "Debug" },
          { leader("db"), group = "Breakpoints" },
        })
      end,
    },
    -- "cmakeseer.nvim",
    -- "LiadOz/nvim-dap-repl-highlights", -- TODO: Configure
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = { commented = true },
    },
  },
  config = function()
    vim.fn.sign_define("DapBreakpoint",             { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition",    { text = "", texthl = "DapConditionalBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected",     { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint",               { text = "", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped",                { text = "", texthl = "DapStopped", linehl = "CursorLine" })
  end,
  keys = {
    -- stylua: ignore start
    { leader("dt"),      desc = "Debug: Terminate",                   mode = { "n" }, function() require("dap").terminate() end },
    { rapid_leader("n"), desc = "Debug: Step over",                   mode = { "n" }, function() require("dap").step_over() end },
    { rapid_leader("s"), desc = "Debug: Step into",                   mode = { "n" }, function() require("dap").step_into() end },
    { rapid_leader("S"), desc = "Debug: Step out",                    mode = { "n" }, function() require("dap").step_out() end },
    { leader("dcc"),     desc = "Debug: Continue or start execution", mode = { "n" }, function() require("dap").continue() end },
    { leader("dC"),      desc = "Debug: Execute to cursor",           mode = { "n" }, function() require("dap").run_to_cursor() end },
    { leader("dp"),      desc = "Debug: Pause execution",             mode = { "n" }, function() require("dap").pause() end },

    -- Breakpoints
    { "<F9>",            desc = "Debug: Toggle breakpoint",           mode = { "n" }, function() require("dap").toggle_breakpoint() end },
    { leader("dbb"),     desc = "Debug: Toggle breakpoint",           mode = { "n" }, function() require("dap").toggle_breakpoint() end },
    { leader("dbc"),     desc = "Debug: Set conditional breakpoint",  mode = { "n" }, set_conditional_breakpoint },
    { leader("dbh"),     desc = "Debug: Set hit breakpoint",          mode = { "n" }, set_hit_breakpoint },
    { leader("dbl"),     desc = "Debug: Set logpoint",                mode = { "n" }, set_logpoint },
    { leader("dba"),     desc = "Debug: Set advanced breakpoint",     mode = { "n" }, set_advanced_breakpoint },
    { leader("dbe"),     desc = "Debug: Set exception breakpoint",    mode = { "n" }, function() require("dap").set_exception_breakpoints() end },

    { leader("dlp"),     desc = "Debug: Preview line execution",      mode = { "n" }, function() require("dap.ui.widgets").preview() end },
    { leader("df"),      desc = "Debug: View current frame stack",    mode = { "n" }, function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames) end },
    { leader("ds"),      desc = "Debug: View scopes",                 mode = { "n" }, function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end },
    { leader("dbs"),     desc = "Debug: List breakpoints",            mode = { "n" }, function() require("telescope").extensions.dap.list_breakpoints() end },
    { leader("dco"),     desc = "Debug: Show commands",               mode = { "n" }, function() require("telescope").extensions.dap.commands() end },
    -- stylua: ignore end
  },
}
