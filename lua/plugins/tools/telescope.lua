local keymaps = require("keymaps.telescope")

-- Setup the telescope plugin.
-- @param _ table: The telescope plugin.
-- @param opts table: The telescope plugin options.
local function config(_, opts)
  require("telescope").setup(opts)
  -- require("telescope").load_extension("refactoring")
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    command = "setlocal nofoldenable",
  })
end

local opts = {
  defaults = {
    mappings = keymaps.mappings,
  },
  pickers = {
    git_files = {
      recurse_submodules = true,
    },
  },
  extensions = {
    cmdline = {
      picker = {
        border = true,
        borderchars = {
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        },
        layout_config = {
          preview_cutoff = 1,
        },
        theme = "dropdown",
        layout_strategy = "center",
        results_title = false,
        sorting_strategy = "ascending",
        cache_picker = {
          disabled = true,
        },
      },
    },
  },
}

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = config,
  keys = keymaps.lazy_keys,
  opts = opts,
}
