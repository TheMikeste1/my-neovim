-- See about replacing with https://github.com/mfussenegger/nvim-dap/issues/198#issuecomment-2764679167
return {
  "Weissle/persistent-breakpoints.nvim",
  cond = false,
  opts = {
    load_breakpoints_event = { "BufReadPost" },
  },
}
