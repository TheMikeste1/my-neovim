require("utilities.file_utilities")

local function extend_rules(opts)
  local npairs = require("nvim-autopairs")

  opts.ft_alias = opts.ft_alias or {}
  for alias, original in pairs(opts.ft_alias) do
    for _, rule in ipairs(npairs.config.rules) do
      ---@cast rule Rule
      if rule.filetypes ~= nil then
        if vim.list_contains(rule.filetypes, original) then
          rule.filetypes[#rule.filetypes + 1] = alias
        end
      end
      if rule.not_filetypes ~= nil then
        if vim.list_contains(rule.not_filetypes, original) then
          rule.not_filetypes[#rule.not_filetypes + 1] = alias
        end
      end
    end
  end
  opts.ft_alias = nil
  npairs.force_attach() -- Reload the rules
end

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    enable_check_bracket_line = false,
    disable_filetype = {
      "TelescopePrompt",
      "snacks_picker_input",
    },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    extend_rules(opts)
    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}
