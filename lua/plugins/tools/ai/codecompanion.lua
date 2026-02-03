---@module "codecompanion"
return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
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
        adapter = "local_ollama",
        tools = {
          opts = {
            auto_submit_errors = true,
            auto_submit_success = true,
            default_tools = {
              "memory",
            },
          },
          ["memory"] = {
            opts = {
              require_approval_before = false,
            },
          },
          ["grep_search"] = {
            opts = {
              require_approval_before = false,
              respect_gitignore = false,
            },
          },
          ["read_file"] = {
            opts = {
              require_approval_before = false,
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
      inline = { adapter = "local_ollama" },
      agent = { adapter = "local_ollama" },
      cmd = { adapter = "local_ollama" },
    },
    adapters = {
      http = {
        local_ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://localhost:11434",
            },
            schema = {
              model = {
                default = "qwen2.5-coder:7b",
              },
            },
          })
        end,
      },
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
