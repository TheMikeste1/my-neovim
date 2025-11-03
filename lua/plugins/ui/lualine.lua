local FILE_NONTYPES = {
  "alpha",
  "notify",
  "noice",
  "fugitive",
  "TelescopePrompt",
  "OverseerForm",
  "OverseerList",
  "neo-tree",
  "lazy",
  "snacks_picker_input",
  "snacks_dashboard",
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
  config = function()
    require("lualine").setup({
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
            fmt = function(str, context)
              if #str > 15 then
                return str:sub(1, 15)
              end
              return str
            end,
          },
          "diagnostics",
        },
        lualine_c = {
          { "filetype", cond = is_enabled_file },
          { eol_type, cond = is_enabled_file },
          { "filename", cond = is_enabled_file },
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
    })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
