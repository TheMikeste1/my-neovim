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
        opts = {
          ---@param ctx CodeCompanion.SystemPrompt.Context
          ---@return string
          system_prompt = function(ctx)
            local prompt = ctx.default_system_prompt
              .. [[
User-specific overrides:
Be wary of Markdown tables with long rows or linebreaks. NeoVim does not render these well. Tables with few columns and cells with little content are generally okay. 120 characters total per row at the absolute most is reasonable. 80 characters is preferred.
]]

            local depth = "3"
            if vim.fn.getcwd() == vim.fn.expand("~") then
              depth = "2"
            end

            local tree = vim.system({ "tree", "--gitignore", "-L", depth }, { text = true, timeout = 1000 }):wait()
            if tree.code == 0 or (tree.code == 0 and tree.signal == 15) then
              prompt = prompt
                .. string.format(
                  [[

Project tree structure (depth of %s):

```
%s```

You may obtain a deeper depth by running `tree --gitignore -L <depth>` if you have command runner access. Try to limit the depth to 3 at a time, and run the command from a folder you do not currently have visibility into.
]],
                  depth,
                  tree.stdout
                )
            end

            return prompt
          end,
        },
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
    prompt_library = {
      markdown = {
        dirs = {
          vim.fs.joinpath(vim.fn.stdpath("config"), "prompts"),
        },
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
