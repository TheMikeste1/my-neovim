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
    -- stylua: ignore start
    { leader("dt"),      desc = "Terminate",                  mode = { "n" }, function() require("dap").terminate() end },
    { rapid_leader("n"), desc = "Step over",                  mode = { "n" }, function() require("dap").step_over() end },
    { rapid_leader("s"), desc = "Step into",                  mode = { "n" }, function() require("dap").step_into() end },
    { rapid_leader("S"), desc = "Step out",                   mode = { "n" }, function() require("dap").step_out() end },
    { leader("dc"),      desc = "Continue debug execution",   mode = { "n" }, function() require("dap").continue() end },
    { leader("dC"),      desc = "Continue debug execution",   mode = { "n" }, function() require("dap").run_to_cursor() end },
    { leader("dp"),      desc = "Pause execution",            mode = { "n" }, function() require("dap").pause() end },
    { leader("dbb"),     desc = "Toggle breakpoint",          mode = { "n" }, function() require("dap").toggle_breakpoint() end },
    { leader("dbc"),     desc = "Set conditional breakpoint", mode = { "n" }, set_conditional_breakpoint },
    { leader("dbh"),     desc = "Set hit breakpoint",         mode = { "n" }, set_hit_breakpoint },
    { leader("dbl"),     desc = "Set logpoint",               mode = { "n" }, set_logpoint },
    { leader("dba"),     desc = "Set advanced breakpoint",    mode = { "n" }, set_advanced_breakpoint },
    { leader("dbe"),     desc = "Set exception breakpoint",   mode = { "n" }, function() require("dap").set_exception_breakpoints() end },
    { leader("dlp"),     desc = "Preview line execution",     mode = { "n" }, function() require("dap.ui.widgets").preview() end },
    { leader("df"),      desc = "View current frame stack",   mode = { "n" }, function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames) end },
    { leader("ds"),      desc = "View scopes",                mode = { "n" }, function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end },
    -- stylua: ignore end
  },
}
