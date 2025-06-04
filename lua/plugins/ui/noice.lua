return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    format = {
      filter = { icon = "!", lang = "zsh" },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
      {
        -- Silence constant "code_action" messages from null-ls
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = vim.tbl_get(message.opts, "progress", "client")
            local title = vim.tbl_get(message.opts, "progress", "title")
            return client == "null-ls" and title == "code_action"
          end,
        },
        opts = { skip = true },
      },
      {
        -- NeoVim messages
        filter = {
          any = {
            {
              event = "msg_show",
              find = "written",
            },
            {
              event = "msg_show",
              find = "more line",
            },
            {
              event = "msg_show",
              find = "fewer line",
            },
            {
              event = "msg_show",
              find = "line less",
            },
            {
              event = "msg_show",
              find = "lines yanked",
            },
            {
              event = "msg_show",
              find = ">ed",
            },
          },
        },
        opts = { skip = true },
      },
      {
        -- Hop
        filter = {
          any = {
            {
              event = "msg_show",
              kind = "echo",
              find = "Hop",
            },
            {
              event = "msg_show",
              kind = "echomsg",
              find = " -> there’s no such thing",
            },
            {
              event = "msg_show",
              kind = "echomsg",
              find = "no remaining sequence starts with",
            },
            {
              event = "msg_show",
              kind = "echomsg",
              find = "-> empty pattern",
            },
          },
        },
        opts = { skip = true },
      },
    },
    views = {
      mini = {
        position = {
          -- row = 0
        },
        timeout = 1000,
        zindex = 25,
      },
    },
  },
}
