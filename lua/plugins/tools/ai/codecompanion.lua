---@module "codecompanion"
return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "stevearc/dressing.nvim", opts = {} },
      "lalitmee/codecompanion-spinners.nvim",
      "ravitemer/codecompanion-history.nvim",
      "bahaaza/mcphub.nvim",
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
### User-Specific Overrides

- Do not use excessive comments in your code.
- Try to answer without tools first, if possible. Use tools only if you need more information.

#### Table‑Width Guidelines

Be wary of Markdown tables with long rows or linebreaks. NeoVim does not render these well. Tables with few columns and cells with little content are generally okay.
When writing Markdown tables, keep every rendered line ≤ 80 characters (120 max absolute).
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
                -- "file_search",
                "get_changed_files",
                "grep_search",
                "memory",
                -- "read_file",
                -- "neovim__find_files",
                -- "neovim__list_directory",
                "neovim__read_file",
                -- "neovim__read_multiple_files",
                "sequentialthinking",
                "memory",
                "filesystem__directory_tree",
                "filesystem__get_file_info",
                "filesystem__list_allowed_directories",
                "filesystem__list_directory",
                "filesystem__list_directory_with_sizes",
                "filesystem__read_media_file",
                "filesystem__read_multiple_files",
                "filesystem__read_text_file",
                "filesystem__search_files",
                "git__git_diff",
                "git__git_diff_staged",
                "git__git_diff_unstaged",
                "git__git_log",
                "git__git_show",
                "git__git_status",
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
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true, -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        },
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
