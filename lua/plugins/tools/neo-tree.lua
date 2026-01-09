local leader = require("keymaps").leader

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

---@type neotree.Config.SortFunction
--- Idk why, but a and b are definitely not the types SortFunction implies
local function sort_files(a, b)
  -- Return true if `a` < `b`

  if a.type == "file" and b.type == "directory" then
    return false
  end
  if a.type == "directory" and b.type == "file" then
    return true
  end

  if a.name == nil or b.name == nil or a.parent_path ~= b.parent_path then
    return a.path:lower() < b.path:lower()
  end

  -- Parameters are the same type
  -- Check if one of the parameters starts with a special character
  local special_chars = {
    ["."] = true,
    ["_"] = true,
    ["~"] = true,
  }

  if special_chars[a.name:sub(1, 1)] and not special_chars[b.name:sub(1, 1)] then
    return true
  end
  if not special_chars[a.name:sub(1, 1)] and special_chars[b.name:sub(1, 1)] then
    return false
  end

  return a.name:lower() < b.name:lower()
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
    "jackielii/neo-tree-harpoon.nvim",
    "folke/snacks.nvim",
    "miversen33/netman.nvim",
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    {
      leader("<C-e>"),
      function()
        local dir = nil
        if
          vim.bo.filetype == "fugitive"
          or vim.bo.filetype == "snacks_dashboard"
          or vim.bo.filetype == "checkhealth"
        then
          dir = vim.fn.getcwd() -- Don't try changing to the fugitive file's dir
        end

        require("neo-tree.command").execute({
          action = "focus",
          position = "left",
          reveal = true,
          dir = dir,
        })
      end,
      desc = "Explorer",
    },
  },
  cmd = { "Neotree" },
  opts = function(_, opts)
    ---@type neotree.Config
    opts = {
      sort_case_insensitive = true,
      sort_function = sort_files,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        "harpoon-buffers",
        "netman.ui.neo-tree",
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
        hijack_netrw_behavior = "disabled",
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
          never_show_by_pattern = {
            ".null-ls*",
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
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
      buffers = {
        follow_current_file = {
          enabled = true,
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
          { source = "remote" },
        },
      },
      use_popups_for_input = false,
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "OverseerList" },
    }

    Snacks = require("snacks")

    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    return opts
  end,
}
