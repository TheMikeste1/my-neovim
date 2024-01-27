--- @module "matchup"

return {
  "andymass/vim-matchup",
  ---@type matchup.Config
  opts = {
    treesitter = {
      enable = true,
      stopline = 500,
    },
  },
}
