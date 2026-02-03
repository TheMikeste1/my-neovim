local leader = require("keymaps").leader

local cached_headers = {}

---Filters out items from harperls.
---@param item snacks.picker.finder.Item,
---@param filter snacks.picker.Filter
---@return boolean
local function filter_out_harperls(item, filter)
  if item.item.source:sub(1, #"Harper") == "Harper" then
    return false
  end

  return true
end

local function handle_api_command(opts)
  vim.notify("Snacks opts: " .. vim.inspect(opts), vim.log.levels.DEBUG)
  if not opts.fargs then
    return
  end

  local maybe_func = require("snacks").picker[opts.fargs[1]]
  if maybe_func ~= nil then
    maybe_func()
    return
  end

  vim.notify("Unknown Snacks command: " .. opts.args)
end

local function format_diagnostic(item, picker)
  -- Tweaked from snacks.picker.format.diagnostic
  -- The only thing I've changed is to put the source before the message

  local format = require("snacks.picker.format")

  local ret = {} ---@type snacks.picker.Highlight[]
  local diag = item.item ---@type vim.Diagnostic
  if item.severity then
    vim.list_extend(ret, format.severity(item, picker))
  end

  if diag.source then
    ret[#ret + 1] = { diag.source, "SnacksPickerDiagnosticSource" }
    ret[#ret + 1] = { " " }
  end

  local message = diag.message
  ret[#ret + 1] = { message }
  Snacks.picker.highlight.markdown(ret)
  ret[#ret + 1] = { " " }

  if diag.code then
    ret[#ret + 1] = { ("(%s)"):format(diag.code), "SnacksPickerDiagnosticCode" }
    ret[#ret + 1] = { " " }
  end

  vim.list_extend(ret, format.filename(item, picker))
  return ret
end

local function generate_select_diagnostics_for_buffer(bufnr)
  return function()
    local sources_set = {}
    for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
      sources_set[diagnostic.source] = true
    end

    local sources = {}
    for key, _ in pairs(sources_set) do
      table.insert(sources, key)
    end

    vim.ui.select(sources, {
      prompt = "Select a source",
    }, function(chosen_source, idx)
      if chosen_source == nil then
        return
      end

      require("snacks").picker.diagnostics({
        layout = { preset = "ivy" },
        format = format_diagnostic,
        filter = {
          cwd = true,
          filter = function(item, filter)
            local source = item.item.source:lower()
            return item.item.source == chosen_source
          end,
        },
      })
    end)
  end
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
    vim.api.nvim_create_user_command("Snacks", handle_api_command, {
      desc = "Access the Snacks API",
      nargs = "*",
      complete = function(arg_so_far, full_cmd, cursor_pos)
        local pickers = {}
        for p, _ in pairs(require("snacks").picker) do
          ---@cast p string
          if #arg_so_far == 0 or p:sub(1, #arg_so_far) == arg_so_far then
            table.insert(pickers, p)
          end
        end
        table.sort(pickers)
        return pickers
      end,
    })
  end,
  config = function(_, opts)
    require("snacks").setup(opts)
    vim.opt.signcolumn = "yes"
    vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
  end,
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
            action = ":lua require('snacks').picker.smart({ hidden = false, filter = { cwd = true } })",
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
        ---@return snacks.dashboard.Item
        function()
          if Snacks.git.get_root() == nil then
            return { enabled = false }
          end

          local output = vim.fn.system("git branch --show-current")
          return {
            title = output,
            align = "center",
          }
        end,
        { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 2 },
        { section = "keys", padding = 2 },
        { section = "startup" },
      },
    },
  },
  keys = {
    {
      leader("."),
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      leader("S"),
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- Pickers
    {
      "<C-p>",
      function()
        require("snacks").picker.smart({ hidden = false, filter = { cwd = true } })
      end,
      desc = "Quick jump to project files",
    },
    {
      leader(leader("f")),
      function()
        require("snacks").picker.smart({ ignored = true, hidden = true, filter = { cwd = true } })
      end,
      desc = "Quick jump to all files",
    },
    {
      leader("ps"),
      function()
        require("snacks").picker.grep_word({
          search = function()
            return vim.fn.input("Grep > ")
          end,
        })
      end,
      desc = "Search for word in files",
    },
    {
      leader(leader("r")),
      function()
        require("snacks").picker.registers()
      end,
      desc = "Show registers",
      mode = { "n", "x" },
    },
    {
      leader("rr"),
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      desc = "Show refactors",
      mode = { "n", "x" },
    },
    {
      "<M-C-F>",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Search in files",
    },
    {
      "<C-f>",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Search in current buffer",
    },
    {
      leader(leader("h")),
      function()
        require("snacks").picker.help()
      end,
      desc = "Search in help tags",
    },
    {
      leader(leader("g")),
      function()
        require("snacks").picker.git_files()
      end,
      desc = "Search in git files",
    },
    {
      leader(leader("s")),
      function()
        require("snacks").picker.spelling()
      end,
      desc = "Search in spell suggest",
    },
    {
      leader(leader("c")),
      function()
        require("snacks").picker.commands()
      end,
      desc = "Search in commands",
    },
    {
      leader(leader("T")),
      function()
        require("snacks").picker.treesitter()
      end,
      desc = "Search in treesitter",
    },
    {
      leader(leader("m")),
      function()
        require("snacks").picker.marks()
      end,
      desc = "Search in marks",
    },
    {
      leader(leader("q")),
      function()
        require("snacks").picker.qflist()
      end,
      desc = "Open quickfix list",
    },
    {
      leader(leader("k")),
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Show keymaps",
    },
    {
      leader("xx"),
      function()
        require("snacks").picker.diagnostics({
          layout = { preset = "ivy" },
          format = format_diagnostic,
          filter = {
            cwd = true,
            filter = filter_out_harperls,
          },
        })
      end,
      desc = "Diagnostics: all",
    },
    {
      leader("xX"),
      function()
        require("snacks").picker.diagnostics_buffer({
          layout = { preset = "ivy" },
          format = format_diagnostic,
          filter = {
            buf = true,
            filter = filter_out_harperls,
          },
        })
      end,
      desc = "Diagnostics: buffer",
    },
    {
      leader("xs"),
      generate_select_diagnostics_for_buffer(nil),
      desc = "Diagnostics: specific source",
    },
    {
      leader("xS"),
      generate_select_diagnostics_for_buffer(0),
      desc = "Diagnostics: buffer specific source",
    },
  },
}
