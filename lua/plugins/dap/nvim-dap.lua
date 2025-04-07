-- TODO
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    local dap_config = require("configs.dap")

    for name, value in pairs(dap_config.adapters()) do
      dap.adapters[name] = value
    end

    for name, value in pairs(dap_config.configurations()) do
      dap.configurations[name] = value
    end
  end,
  keys = require("keymaps.dap").lazy_keys,
  dependencies = {
    "jbyuki/one-small-step-for-vimkind",
    "cmakeseer.nvim",
    -- "LiadOz/nvim-dap-repl-highlights", -- TODO: Configure
  },
}
