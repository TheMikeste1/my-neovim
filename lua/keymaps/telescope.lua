local mod = {}

---Filters out items from harperls.
---@param item snacks.picker.finder.Item,
---@param filter snacks.picker.Filter
---@return boolean
local function filter_out_harperls(item, filter)
  if item.item.source == "Harper" then
    return false
  end

  return true
end

-- Search for a word in files.
local function grep_search()
  local input = vim.fn.input("Grep > ")
  if input ~= "" then
    require("snacks").picker.grep_word({ search = input })
  end
end

-- Send the selected entry to the quickfix list and open the list.
-- @param prompt_buffer_number number: The prompt buffer number.
local function send_to_quickfix_list(prompt_buffer_number)
  require("telescope.actions").smart_send_to_qflist(prompt_buffer_number)
  require("snacks").picker.qflist()
end

mod.mappings = {
  i = {
    ["<M-C-q>"] = send_to_quickfix_list,
  },
  n = {
    ["<M-C-q>"] = send_to_quickfix_list,
  },
}

mod.lazy_keys = {
  {
    "<C-p>",
    function()
      require("snacks").picker.smart({ hidden = false, filter = { cwd = true } })
    end,
    desc = "Quick jump to project files",
  },
  {
    "<leader><leader>f",
    function()
      require("snacks").picker.smart({ ignored = true, hidden = true, filter = { cwd = true } })
    end,
    desc = "Quick jump to all files",
  },
  {
    "<leader>ps",
    grep_search,
    desc = "Search for word in files",
  },
  {
    "<leader><leader>r",
    function()
      require("snacks").picker.registers()
    end,
    desc = "Show registers",
    mode = { "n", "x" },
  },
  {
    "<leader>rr",
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
    "<leader><leader>h",
    function()
      require("snacks").picker.help()
    end,
    desc = "Search in help tags",
  },
  {
    "<leader><leader>g",
    function()
      require("snacks").picker.git_files()
    end,
    desc = "Search in git files",
  },
  {
    "<leader><leader>s",
    function()
      require("snacks").picker.spelling()
    end,
    desc = "Search in spell suggest",
  },
  {
    "<leader><leader>c",
    function()
      require("snacks").picker.commands()
    end,
    desc = "Search in commands",
  },
  {
    "<leader><leader>T",
    function()
      require("snacks").picker.treesitter()
    end,
    desc = "Search in treesitter",
  },
  {
    "<leader><leader>m",
    function()
      require("snacks").picker.marks()
    end,
    desc = "Search in marks",
  },
  {
    "<leader><leader>q",
    function()
      require("snacks").picker.qflist()
    end,
    desc = "Open quickfix list",
  },
  {
    "<leader>xx",
    function()
      require("snacks").picker.diagnostics({
        layout = { preset = "ivy" },
        filter = {
          cwd = true,
          filter = filter_out_harperls,
        },
      })
    end,
    desc = "Diagnostics",
  },
  {
    "<leader>xX",
    function()
      require("snacks").picker.diagnostics_buffer({
        layout = { preset = "ivy" },
        filter = {
          buf = true,
          filter = filter_out_harperls,
        },
      })
    end,
    desc = "Buffer Diagnostics",
  },
}

return mod
