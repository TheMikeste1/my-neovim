local leader = require("keymaps").leader

return {
  "atiladefreitas/dooing",
  opts = {
    window = {
      width = 55 * 2,
      height = 20 * 2,
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
