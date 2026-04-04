return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  cond = true,
  branch = "main",
  init = function()
    local function map(query, lhs, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    map("@assignment.inner", "i=", "Select inner part of an assignment")
    map("@assignment.lhs", "aah", "Select left side of an assignment")
    map("@assignment.outer", "a=", "Select outer part of an assignment")
    map("@assignment.rhs", "aal", "Select right side of an assignment")
    map("@block.inner", "ib", "Select inner part of a block")
    map("@block.outer", "ab", "Select outer part of a block")
    map("@call.inner", "ica", "Select inner part of a call")
    map("@call.outer", "aca", "Select outer part of a call")
    map("@class.inner", "icl", "Select inner part of a class")
    map("@class.outer", "acl", "Select outer part of a class")
    map("@comment.inner", "ico", "Select inner part of a comment")
    map("@comment.outer", "aco", "Select outer part of a comment")
    map("@function.inner", "if", "Select inner part of a function")
    map("@function.outer", "af", "Select outer part of a function")
    map("@loop.inner", "il", "Select inner part of a loop")
    map("@loop.outer", "al", "Select outer part of a loop")
    map("@parameter.inner", "ip", "Select inner part of a parameter")
    map("@parameter.outer", "ap", "Select outer part of a parameter")
  end,
  opts = {
    select = {
      enable = true,
      lookahead = true,
      selection_modes = {
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
    lsp_interop = {
      enable = true,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {},
    },
  },
}
