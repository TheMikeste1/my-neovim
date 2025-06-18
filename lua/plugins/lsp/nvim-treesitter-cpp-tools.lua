return {
  "Badhi/nvim-treesitter-cpp-tools",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = function()
    local options = {
      preview = {
        quit = "q", -- optional keymapping for quit preview
        accept = "<tab>", -- optional keymapping for accept preview
      },
      header_extension = "hpp", -- optional
      source_extension = "cpp", -- optional
    }
    return options
  end,
  config = true,
  ft = { "cpp", "c" },
}
