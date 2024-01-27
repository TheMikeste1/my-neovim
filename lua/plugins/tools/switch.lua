return {
  -- TODO: check on dial.nvim
  "AndrewRadev/switch.vim",
  cond = true,
  init = function()
    vim.g.switch_mapping = ""
    vim.g.speeddating_no_mappings = 1
  end,
  config = function()
    vim.cmd([[
      " Avoid issues because of us remapping <c-a> and <c-x> below
      nnoremap <Plug>SpeedDatingFallbackUp <c-a>
      nnoremap <Plug>SpeedDatingFallbackDown <c-x>
    ]])
    vim.g.switch_custom_definitions = {
      { "private", "protected", "public" },
      { "==", "!=" },
      { "<", ">" },
      { "<=", ">=" },
    }
  end,
  keys = {
    {
      "<C-a>",
      function()
        if vim.api.nvim_call_function("switch#Switch", {}) ~= 1 then
          vim.api.nvim_call_function("speeddating#increment", { vim.v.count1 })
        end
      end,
      mode = "n",
      desc = "Increment under cursor",
    },
    {
      "<C-x>",
      function()
        if vim.api.nvim_call_function("switch#Switch", { { ["reverse"] = 1 } }) ~= 1 then
          vim.api.nvim_call_function("speeddating#increment", { -vim.v.count1 })
        end
      end,
      mode = "n",
      desc = "Increment under cursor",
    },
  },
  dependencies = {
    "tpope/vim-speeddating",
  },
}
