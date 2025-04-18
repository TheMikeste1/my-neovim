local function harpoon_index(config, node, _)
  local harpoon_list = require("harpoon"):list()
  local path = node:get_id()
  local harpoon_key = vim.uv.cwd()

  for i, item in ipairs(harpoon_list.items) do
    local value = item.value
    if string.sub(item.value, 1, 1) ~= "/" then
      value = harpoon_key .. "/" .. item.value
    end

    if value == path then
      vim.print(path)
      return {
        text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
        highlight = config.highlight or "NeoTreeDirectoryIcon",
      }
    end
  end
  return {}
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
    "s1n7ax/nvim-window-picker",
    "jackielii/neo-tree-harpoon.nvim",
    "folke/snacks.nvim",
  },
  keys = {
    {
      "<leader><C-e>",
      function()
        require("neo-tree.command").execute({
          action = "focus",
          position = "left",
          reveal = true,
        })
      end,
      desc = "Explorer",
    },
    {
      "<leader><C-b>",
      function()
        require("neo-tree.command").execute({
          action = "show",
          position = "left",
          reveal = true,
          toggle = true,
        })
      end,
      desc = "Toggle sideview",
    },
  },
  cmd = { "Neotree" },
  opts = function(_, opts)
    Snacks = require("snacks")

    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        "harpoon-buffers",
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.opt_local.relativenumber = true
          end,
        },
      },
      filesystem = {
        components = {
          harpoon_index = harpoon_index,
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {},
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        renderers = {
          file = {
            { "icon" },
            { "name", use_git_status_colors = true },
            { "harpoon_index" }, --> This is what actually adds the component in where you want it
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
        },
      },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem" },
          { source = "harpoon-buffers" },
          { source = "buffers" },
          { source = "git_status" },
          { source = "document_symbols" },
        },
      },
      use_popups_for_input = false,
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "OverseerList", "nofile" },
    }

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    return opts
  end,
}
