---@module "codecompanion"
return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- { "stevearc/dressing.nvim", opts = {} },
      "lalitmee/codecompanion-spinners.nvim",
      "ravitemer/codecompanion-history.nvim",
    },
    init = function()
      vim.keymap.set({ "n", "v" }, "<C-g>cc", "<cmd>CodeCompanionChat Toggle<cr>")
      vim.keymap.set({ "n", "v" }, "<C-g>cn", "<cmd>CodeCompanionChat<cr>")
      vim.keymap.set({ "n", "v" }, "<C-g>ca", "<cmd>CodeCompanionChat Add<cr>")
      vim.keymap.set({ "n", "v" }, "<C-g>cp", "<cmd>CodeCompanion<cr>")

      vim.cmd([[cnoreabbrev <silent> CC        CodeCompanion]])
      vim.cmd([[xnoremap <silent> CC        :CodeCompanion<CR>]])
      vim.cmd([[cnoreabbrev <silent> CCChat    CodeCompanionChat]])
      vim.cmd([[xnoremap <silent> CCChat    :CodeCompanionChat<CR>]])
      vim.cmd([[cnoreabbrev <silent> CCActions CodeCompanionActions]])
      vim.cmd([[xnoremap <silent> CCActions :CodeCompanionActions<CR>]])
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
- Do not use excessive comments in your code.
- Try to answer without tools first, if possible. Use tools only if you need more information.

Be wary of Markdown tables with long rows or linebreaks. NeoVim does not render these well. Tables with few columns and cells with little content are generally okay.
When writing Markdown tables, keep every rendered line ≤ 80 characters.
‑ Use only a few narrow columns.
- Avoid using line break (`<br>`, `\\n`, etc.) in tables; NeoVim cannot render them.
‑ If a table would exceed the limit, split it into smaller tables or replace the data with prose.
]]

              local depth = "3"
              if vim.fn.getcwd() == vim.fn.expand("~") then
                depth = "2"
              end

              local tree = vim.system({ "tree", "--gitignore", "-L", depth }, { text = true, timeout = 1000 }):wait()
              if tree.code == 0 then
                prompt = prompt
                  .. string.format(
                    [[

Project tree structure (depth of %s):

```
%s```
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
                "ask_questions",
                "file_search",
                "get_changed_files",
                "get_diagnostics",
                "grep_search",
                "memory",
                "read_file",
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
        inline = {
          adapter = "local_ollama",
          keymaps = {
            stop = {
              modes = { n = "<C-q>" },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop request",
            },
          },
        },
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
                num_ctx = {
                  default = 8192 * 2 * 2,
                },
                model = {
                  default = "gemma4:e4b",
                },
                choices = {
                  ["gemma4:e4b"] = { opts = { can_reason = true } },
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
    keys = {
      {
        "<C-g>k",
        function()
          vim.cmd("CodeCompanion")
        end,
        desc = "Inline AI",
        mode = { "n", "v" },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      ft_alias = {
        codecompanion = "markdown",
      },
    },
  },
}
