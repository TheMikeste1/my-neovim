return {
  "Badhi/nvim-treesitter-cpp-tools",
  cond = false, -- Until newest treesitter is supported
  dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts= {
      preview = {
        quit = "q", -- optional keymapping for quit preview
        accept = "<tab>", -- optional keymapping for accept preview
      },
      header_extension = "hpp", -- optional
      source_extension = "cpp", -- optional
    },
  config = true,
  ft = { "cpp", "c" },
}
