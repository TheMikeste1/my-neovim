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
  init = function()
    vim.keymap.set({ "n", "v" }, "<C-g>cc", "<cmd>CodeCompanionChat Toggle<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>cn", "<cmd>CodeCompanionChat<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>ca", "<cmd>CodeCompanionChat Add<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>cp", "<cmd>CodeCompanion<cr>")
  end,
  opts = {
    interactions = {
      chat = {
        adapter = "gemini_cli",
        tools = {
          opts = {
            auto_submit_errors = true,
            auto_submit_success = true,
            default_tools = {
              "memory",
            },
            ["memory"] = {
              opts = {
                require_approval_before = false,
              },
            },
          },
        },
        variables = {
          ["buffer"] = {
            opts = {
              -- Always sync the buffer by sharing its "diff"
              -- Or choose "all" to share the entire buffer
              default_params = "diff",
            },
          },
        },
      },
      inline = { adapter = "gemini_cli" },
      agent = { adapter = "gemini_cli" },
      cmd = { adapter = "gemini_cli" },
    },
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        icons = {
          chat_context = "📎️",
        },
        fold_context = true,
      },
    },
    extensions = {
      spinner = {
        enabled = true,
        opts = { style = "lualine" },
      },
      history = {
        enabled = true,
        opts = { picker = "snacks" },
      },
    },
  },
}
