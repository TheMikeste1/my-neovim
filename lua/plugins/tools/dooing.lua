local leader = require("keymaps").leader

return {
  "atiladefreitas/dooing",
  opts = {
    ui = { style = "modern" },
    window = {
      dimensions = function()
        return {
          width = math.max(40, math.floor(vim.o.columns * 0.4)),
          height = math.max(10, math.floor(vim.o.lines * 0.6)),
        }
      end,
    },
    per_project = {
      on_missing = "auto_create",
    },
    keymaps = {
      toggle_window = leader("tD"),
      open_project_todo = leader("td"),
    },
  },
}
