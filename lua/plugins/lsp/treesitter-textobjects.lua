local leader = require("keymaps").leader

-- Text objects and language support:
--  https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#built-in-textobjects
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  cond = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      textobjects = {
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            -- [leader("df")] = "@function.outer",
            -- [leader("dF")] = "@class.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of a assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of a assignment" },
            ["aah"] = { query = "@assignment.lhs", desc = "Select left side of a assignment" },
            ["aal"] = { query = "@assignment.rhs", desc = "Select right side of a assignment" },
            ["ab"] = { query = "@block.outer", desc = "Select outer part of a block" },
            ["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
            ["aca"] = { query = "@call.outer", desc = "Select outer part of a call" },
            ["ica"] = { query = "@call.inner", desc = "Select inner part of a call" },
            ["acl"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["icl"] = { query = "@class.inner", desc = "Select inner part of a class" },
            ["aco"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
            ["ico"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            -- FIXME: These conflict with paragraph motions
            ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
            ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
          },
          selection_modes = {
            -- "v" -- charwise
            -- "V" -- linewise
            -- "<C-v>" -- blockwise
            ["@assignment"] = "v",
            ["@block"] = "V",
            ["@call"] = "v",
            ["@class"] = "V",
            ["@function"] = "V",
            ["@loop"] = "V",
            ["@parameter"] = "v",
          },
          include_surrounding_whitespace = false,
        },
      },
    })
  end,
}
