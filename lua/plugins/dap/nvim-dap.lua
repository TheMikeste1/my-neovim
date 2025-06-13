-- TODO
return {
  "mfussenegger/nvim-dap",
  keys = require("keymaps.dap").lazy_keys,
  dependencies = {
    "jbyuki/one-small-step-for-vimkind",
    "cmakeseer.nvim",
    -- "LiadOz/nvim-dap-repl-highlights", -- TODO: Configure
  },
}
