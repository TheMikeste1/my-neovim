if vim.g.vscode then
  return
end

local Set = require("utilities.set").Set

--- Tools used for all filetypes.
local GLOBAL_TOOLS = Set({ "editorconfig-checker", "harper-ls" })
--- Tools by filetype.
local FT_TOOLS = {
  c = Set({
    "clang-format",
    "clangd",
    "codelldb",
  }),
  cmake = Set({
    "cmakelang",
    "cmakelint",
    "neocmakelsp",
  }),
  dockerfile = Set({ "hadolint" }),
  javascript = Set({ "typescript-language-server" }),
  lua = Set({
    "lua-language-server",
    "stylua",
  }),
  makefile = Set({ "checkmake" }),
  python = Set({
    "black",
    "debugpy",
    "isort",
    "mypy",
    "pylint",
    -- "pyrefly",
    "pyright",
  }),
  sh = Set({
    "bash-language-server",
    "beautysh",
    "shellcheck",
    "shellharden",
  }),
  sql = Set({ "sqlfluff" }),
  systemd = Set({
    "systemd-language-server",
    "systemdlint",
  }),
  toml = Set({
    "ansible-lint",
    "taplo",
  }),
  yaml = Set({
    "yamlfix",
    "yamlfmt",
    "yamllint",
  }),
}
FT_TOOLS.cpp = FT_TOOLS.c

---@param tools string[]
---@return string # The tools formatted into a list.
local function construct_tools_list(tools)
  local sout = ""
  for _, tool in ipairs(tools) do
    sout = sout .. "\n\t- " .. tool
  end
  return sout
end

---@param tools Set<string>
---@return string[] missing_tools The set of missing tools.
local function get_missing_tools(tools)
  local missing_tools = vim.deepcopy(tools)
  for _, package in ipairs(require("mason-registry").get_installed_package_names()) do
    missing_tools[package] = nil
  end

  return vim.tbl_keys(missing_tools)
end

vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Check for missing global tools",
  once = true,
  callback = function()
    local missing_tools = get_missing_tools(GLOBAL_TOOLS)
    if #missing_tools > 0 then
      local tools_list = construct_tools_list(missing_tools)
      vim.notify("Missing global tools. Run ToolInstall global to install." .. tools_list)
    end
  end,
})

for filetype in pairs(FT_TOOLS) do
  vim.api.nvim_create_autocmd("FileType", {
    desc = string.format("Check for missing tools for %s files", filetype),
    pattern = filetype,
    once = true,
    callback = function()
      local missing_tools = get_missing_tools(FT_TOOLS[filetype])
      if #missing_tools > 0 then
        local tools_list = construct_tools_list(missing_tools)
        vim.notify(string.format("Missing %s tools. Run ToolInstall %s to install.", filetype, filetype) .. tools_list)
      end
    end,
  })
end

vim.api.nvim_create_user_command("ToolInstall", function(opts)
  if #opts.fargs == 0 then
    opts.args = vim.bo.filetype
    opts.fargs[1] = vim.bo.filetype
  end

  local tools = nil
  if opts.fargs[1] == "global" then
    tools = GLOBAL_TOOLS
  else
    tools = FT_TOOLS[opts.fargs[1]]
  end

  if tools == nil then
    vim.notify(string.format("Cannot find tools for %s files", opts.args), vim.log.levels.ERROR)
    return
  end

  local missing_tools = get_missing_tools(tools)
  if #missing_tools == 0 then
    vim.notify(string.format("Not missing any tools for %s files", opts.args))
    return
  end

  local tools_list = construct_tools_list(missing_tools)
  vim.notify(string.format("Installing %s tools for %s files", #missing_tools, opts.args) .. tools_list)
  vim.cmd("MasonInstall " .. table.concat(missing_tools, " "))
end, {
  desc = "Install a tool for a filetype. Pass with no args to install tools for the current filetype.",
  nargs = "?",
  complete = "filetype",
})
