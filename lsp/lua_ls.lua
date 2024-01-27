local function on_nonnvim_init(_client, _path)
  return true
end

local function on_nvim_init(client, _path)
  client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
    runtime = {
      version = "LuaJIT",
    },
    diagnostics = {
      disabled = { "mixed_table" },
      globals = {
        "vim",
        "require",
      },
    },
    workspace = {
      checkThirdParty = true,
      library = vim.api.nvim_get_runtime_file("", true),
    },
  })

  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  return true
end

---@param path string The path to the project.
---@return boolean is_project If the current project is for Neovim or a Neovim plugin.
local function is_nvim_project(path)
  -- Sometimes I'm naughty and symlink my config folder 🤐
  path = vim.fn.resolve(vim.fn.expand(path))
  local config_path = vim.fn.stdpath("config")
  config_path = vim.fn.resolve(vim.fn.expand(config_path))
  return path == config_path
end

local function on_init(client)
  client.config.settings.Lua = client.config.settings.Lua or {}

  ---@type string
  local path = client.workspace_folders[1].name

  -- Load settings
  local luarc_exists = vim.loop.fs_stat(path .. "/.luarc.json")
  local luarc_c_exists = vim.loop.fs_stat(path .. "/.luarc.jsonc")
  if luarc_exists or luarc_c_exists then
    local file_path = nil
    if luarc_exists then
      file_path = path .. "/.luarc.json"
    elseif luarc_c_exists then
      file_path = path .. "/.luarc.jsonc"
    end

    assert(file_path, "file_path is nil, but one of the configs exists???")

    local file = io.open(file_path, "r")
    if file == nil then
      vim.notify("Unable to read luarc file `" .. file_path .. "`", vim.log.levels.ERROR)
    else
      local file_contents = file:read("a")
      file:close()

      local file_settings = vim.json.decode(file_contents)
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, file_settings)
    end
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
