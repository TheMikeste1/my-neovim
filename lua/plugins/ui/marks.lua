return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  config = true,
  opts = {
    builtin_marks = { ".", "<", ">", "^", "`", "[", "]" },
    excluded_filetypes = {
      "",
      "DressingInput",
      "noice",
      "Telescope",
      "Neotest Summary",
      "dapui_console",
      "dapui_repl",
      "dapui_stacks",
      "dapui_scopes",
      "dapui_watches",
      "dapui_breakpoints",
      "dap-repl",
      "OverseerForm",
    },
    excluded_buftypes = { "nofile" },
  },
}
