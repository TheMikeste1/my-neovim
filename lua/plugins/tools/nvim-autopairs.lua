require("utilities.file_utilities")

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    disable_filetype = {
      "TelescopePrompt",
      "snacks_picker_input",
    },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
  end,
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}
