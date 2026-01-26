local FILE_NONTYPES = {
  "alpha",
  "notify",
  "noice",
  "fugitive",
  "TelescopePrompt",
  "OverseerForm",
  "OverseerList",
  "OverseerOutput",
  "neo-tree",
  "lazy",
  "snacks_picker_input",
  "snacks_dashboard",
  "dap-repl",
  "dapui_console",
  "dapui_scopes",
  "dapui_breakpoints",
  "dapui_stacks",
  "dapui_watches",
}

---@return boolean
local function is_enabled_file()
  local filetype = vim.bo.filetype
  for _, nontype in ipairs(FILE_NONTYPES) do
    if filetype == nontype then
      return false
    end
  end
  return true
end

local function eol_type()
  local format = vim.bo.fileformat:upper()
  if format ~= "UNIX" then
    return "[" .. format .. "]"
  end
  return ""
end

local function get_recording_status()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "Recording to " .. reg
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy", -- VeryLazy to dodge flickering with messages before nvim is loaded
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = {
        statusline = {},
        winbar = FILE_NONTYPES,
      },
    },
    extensions = {
      "neo-tree",
      "trouble",
    },
    sections = {
      lualine_a = {
        { "mode", separator = { right = "" } },
        {
          get_recording_status,
          separator = { right = "" },
          color = { bg = "#f39660" },
        },
      },
      lualine_b = {
        {
          "branch",
          fmt = function(branch, context)
            local maybe_issue = branch:match("[A-Z0-9]+-[A-Z0-9]+")
            if maybe_issue ~= nil then
              return maybe_issue
            end

            if #branch > 15 then
              return branch:sub(1, 15)
            end
            return branch
          end,
        },
        "diagnostics",
      },
      lualine_c = {
        { "filetype", cond = is_enabled_file },
        { eol_type, cond = is_enabled_file },
        { "filename", cond = is_enabled_file },
        require("codecompanion._extensions.spinner.styles.lualine").get_lualine_component(),
      },
      lualine_x = {
        {
          function()
            local value = require("noice").api.status.message.get()
            if #value > 128 then
              value = string.sub(value, 1, 125) .. "..."
            end
            value = string.gsub(value, "\n", "")
            return value
          end,
          cond = require("noice").api.status.message.has,
        },
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
        },
        {
          "overseer",
        },
      },
    },
    inactive_winbar = {
      lualine_b = { { "filename", path = 1 } },
    },
    winbar = {
      lualine_b = { { "filename", path = 1 } },
      lualine_c = {
        { "aerial", colored = true },
      },
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
