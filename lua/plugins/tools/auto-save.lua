return {
  "pocco81/auto-save.nvim",
  opts = {
    execution_message = {
      message = "", -- Disable the message output
    },
    trigger_events = { "InsertLeave", "TextChanged" },
    condition = function(buf_num)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      if
        fn.getbufvar(buf_num, "&modifiable") == 1 and utils.not_in(
          fn.getbufvar(buf_num, "&filetype"),
          { "OverseerForm" }
        )
      then
        return true -- met condition(s), can save
      end
      return false -- can't save
    end,
  },
  lazy = false,
}
