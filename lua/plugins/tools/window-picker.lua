return {
  "s1n7ax/nvim-window-picker",
  opts = {
    hint = "floating-big-letter",
    filter_rules = {
      include_current_win = false,
      autoselect_one = true,
      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "neo-tree", "neo-tree-popup", "notify", "noice" },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { "quickfix" },
      },
    },
  },
  keys = {
    {
      "<leader>,",
      function()
        local window_id = require("window-picker").pick_window()
        if window_id ~= nil then
          vim.api.nvim_set_current_win(window_id)
        end
      end,
      mode = {
        "n",
        "v",
      },
    },
  },
}
