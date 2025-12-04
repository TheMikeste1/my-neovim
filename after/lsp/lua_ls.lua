local function on_nonnvim_init(_client, _path)
  return true
end

local function on_nvim_init(client, _path)
  -- See nvim-lspconfig/lsp/lua_ls.lua
  client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
    runtime = {
      version = "LuaJIT",
      -- Tell the language server how to find Lua modules same way as Neovim
      -- (see `:h lua-module-load`)
      path = {
        "lua/?.lua",
        "lua/?/init.lua",
      },
    },
    diagnostics = {
      disabled = { "mixed_table" },
    },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
      },
    },
  })

  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  return true
end

---@param path string The path to the project.
---@return boolean is_project If the current project is for Neovim or a Neovim plugin.
local function is_nvim_project(path)
  path = vim.fn.resolve(assert(vim.fn.expand(path)))
  local config_path = vim.fn.stdpath("config")
  config_path = vim.fn.resolve(assert(vim.fn.expand(config_path)))
  return path == config_path
end

local function on_init(client)
  client.config.settings.Lua = client.config.settings.Lua or {}

  if client.workspace_folders == nil then
    -- Individual file
    return true
  end

  ---@type string
  local path = client.workspace_folders[1].name

  -- Load settings
  local luarc_exists = vim.loop.fs_stat(path .. "/.luarc.json")
  local luarc_c_exists = vim.loop.fs_stat(path .. "/.luarc.jsonc")
  if not luarc_exists and not luarc_c_exists then
    return true
  end

  -- Load additional settings
  if is_nvim_project(path) then
    return on_nvim_init(client, path)
  end
  return on_nonnvim_init(client, path)
end

return {
  on_init = on_init,
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      doc = {
        privateName = { "^_" },
      },
    },
  },
}
