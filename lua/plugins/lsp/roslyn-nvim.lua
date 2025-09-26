return {
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    silent = true,
  },
  init = function()
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    })
  end,
  config = function(_, opts)
    require("mason-registry").sources:append("github:Crashdummyy/mason-registry")
    require("roslyn").setup(opts)
  end,
}
