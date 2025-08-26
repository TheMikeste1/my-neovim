local cached_headers = {}

local function handle_api_command(opts)
  vim.notify("Snacks opts: " .. vim.inspect(opts), vim.log.levels.DEBUG)
  if opts.fargs and opts.fargs[1] == "resume" then
    require("snacks").picker.resume()
    return
  end

  vim.notify("Unknown Snacks command: " .. opts.args)
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("TabNewEntered", {
      group = vim.api.nvim_create_augroup("default_tab", {}),
      desc = "Open dashboard on new, empty tab",
      pattern = "*",
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if filename == "" then
          require("snacks").dashboard({ buf = 0, win = 0 })
        end
      end,
    })
    vim.api.nvim_create_user_command("Snacks", handle_api_command, { desc = "Access the Snacks API", nargs = "*" })
  end,
  config = true,
  ---@type snacks.Config
  opts = {
    styles = {
      dashboard = {
        position = "current",
      },
      scratch = {
        position = "bottom",
      },
    },
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      animate = {
        enabled = true,
      },
    },
    input = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    dashboard = {
      preset = {
        keys = {
          { key = "e", icon = "", desc = "New file", action = ":enew" },
          {
            key = "<C-p>",
            icon = "󰈞",
            desc = "Find file",
            action = ":lua require('snacks').picker.smart({ hidden = false })",
          },
          { key = "<M-C-F>", icon = "󰊄", desc = "Live grep", action = ":lua require('snacks').picker.grep()" },
          { key = "s", icon = "", desc = "Open last session", section = "session" },
          {
            key = "c",
            icon = "",
            desc = "Configuration",
            action = function()
              local dir = vim.fn.stdpath("config")
              vim.cmd.tcd(dir)
              vim.notify(string.format("Tab changed directory to %s", dir))
              require("snacks").dashboard.update()
            end,
          },
          {
            key = "p",
            icon = "󰚥",
            desc = "Plugin Folder",
            action = function()
              local dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
              vim.cmd.tcd(dir)
              vim.notify(string.format("Tab changed directory to %s", dir))
              require("snacks").dashboard.update()
            end,
          },
          { key = "t", icon = "", desc = "Open terminal", action = ":terminal" },
          { key = "u", icon = "", desc = "Update plugins", action = ":Lazy sync" },
          { key = "q", icon = "󰅚", desc = "Close", action = ":q" },
        },
      },
      formats = {
        header = function()
          local buffer_id = vim.api.nvim_get_current_buf()
          local buftype = vim.fn.getbufvar(buffer_id, "&filetype")
          if buftype ~= "snacks_dashboard" then
            local bufs = vim.api.nvim_list_bufs()
            for _, buf_id in ipairs(bufs) do
              buftype = vim.fn.getbufvar(buf_id, "&filetype")
              if buftype == "snacks_dashboard" then
                buffer_id = buf_id
                break
              end
            end
          end

          local cached_header = cached_headers[buffer_id]
          if cached_header ~= nil then
            return cached_header
          end

          local headers = vim.split(vim.fn.glob(string.format("%s/ascii_art/*.txt", vim.fn.stdpath("config"))), "\n")
          local index = math.random(#headers)
          local header_file = headers[index]
          local header_lines = vim.fn.readfile(header_file)
          local max_length = 0
          for _, line in ipairs(header_lines) do
            if #line > max_length then
              max_length = #line
            end
          end

          for i, line in ipairs(header_lines) do
            header_lines[i] = line .. string.rep(" ", max_length - #line)
          end
          local header = table.concat(header_lines, "\n")
          local header_item = { header, align = "center", hl = "SnacksDashboardHeader" }
          cached_headers[buffer_id] = header_item

          -- Clean up memory once the buffer is closed
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = buffer_id,
            once = true,
            callback = function()
              cached_headers[buffer_id] = nil
            end,
          })

          return header_item
        end,
      },
      sections = {
        { section = "header", padding = { 1, 1 } },
        function()
          local dirname = vim.fn.getcwd()
          dirname = vim.fn.fnamemodify(dirname, ":~")
          ---@type snacks.dashboard.Item
          return { title = dirname, align = "center" }
        end,
        { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
        { section = "keys", padding = 2 },
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}
