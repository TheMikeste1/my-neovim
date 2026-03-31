---@class opts TSConfig
function config(_, opts)
  require("nvim-treesitter.configs").setup(opts)
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.cosmos = {
    install_info = {
      url = "https://github.com/TheMikeste1/tree-sitter-cosmos.git",
      files = { "src/parser.c" },
      queries = "queries/neovim", -- also install queries from given directory
    },
    filetype = "cosmos",
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  cond = true,
  build = ":TSUpdate",
  cmd = { "TSUpdateSync" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    auto_install = true,
    highlight = { enable = not vim.g.vscode },
    indent = { enable = not vim.g.vscode },
  },
  config = config,
}
