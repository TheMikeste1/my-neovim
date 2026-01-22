---@module "codecompanion"
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "stevearc/dressing.nvim", opts = {} },
    "lalitmee/codecompanion-spinners.nvim",
    "ravitemer/codecompanion-history.nvim",
  },
  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = "gemini_cli",
        },
        inline = {
          adapter = "gemini_cli",
        },
        agent = {
          adapter = "gemini_cli",
        },
        cmd = {
          adapter = "gemini_cli",
        },
      },
      adapters = {},

      display = {
        action_palette = {
          provider = "snacks",
        },
      },

      extensions = {
        spinner = {
          enabled = true,
          opts = {
            style = "lualine",
          },
        },
        history = {
          enabled = true,
          opts = {
            picker = "snacks",
          },
        },
      },
    })

    -- Keymaps
    vim.keymap.set({ "n", "v" }, "<C-g>cc", "<cmd>CodeCompanionChat Toggle<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>cn", "<cmd>CodeCompanionChat<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>ca", "<cmd>CodeCompanionChat Add<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>cp", "<cmd>CodeCompanion<cr>")
  end,
}
