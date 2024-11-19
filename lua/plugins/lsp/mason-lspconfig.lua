local function on_lua_nonvim_init(client, path)
  return true
end

local function on_lua_vim_init(client, path)
  if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
    local file_path = nil
    if vim.loop.fs_stat(path .. "/.luarc.json") then
      file_path = path .. "/.luarc.json"
    elseif vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      file_path = path .. "/.luarc.jsonc"
    end

    if file_path ~= nil then
      local file = io.open(file_path, "r")
      if file == nil then
        vim.notify("Unable to read luarc file `" .. file_path .. "`", vim.log.levels.ERROR)
      else
        local file_contents = file:read("a")
        file:close()

        client.config.settings.Lua = vim.json.decode(file_contents)
      end
    end
  end

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
    doc = {
      privateName = { "^_" },
    },
    telemetry = {
      enable = false,
    },
  })

  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  return true
end

local function on_lua_init(client)
  local path = client.workspace_folders[1].name
  local config_path = vim.fn.stdpath("config")[1]
  if path == config_path then
    return on_lua_nonvim_init(client, path)
  else
    return on_lua_vim_init(client, path)
  end
end

local function setup_lsp(server, opts)
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  capabilities.textDocument.foldingRange = { -- Used by nvim-ufo
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  opts = opts or {}
  opts.capabilities = capabilities
  lspconfig[server].setup(opts)
end

return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      automatic_installation = true,
      handlers = {
        -- Default
        function(server_name)
          setup_lsp(server_name)
        end,
        ["rust_analyzer"] = function()
          -- setup_lsp("rust_analyzer", {
          --   settings = {
          --     ["rust-analyzer"] = {
          --       checkOnSave = true,
          --       check = {
          --         command = "clippy",
          --       },
          --     },
          --   },
          -- })
        end,
        ["bashls"] = function()
          setup_lsp("bashls", {
            filetypes = { "bash", "sh", "zsh" },
          })
        end,
        ["clangd"] = function()
          setup_lsp("clangd", {
            cmd = {
              "clangd",
              "--offset-encoding=utf-16",
              "--header-insertion=iwyu",
              "--header-insertion-decorators",
              "--import-insertions",
              "--malloc-trim",
            },
          })
        end,
        ["lua_ls"] = function()
          setup_lsp("lua_ls", {
            on_init = on_lua_init,
          })
        end,
        ["zls"] = function()
          setup_lsp("zls", {
            settings = {
              enable_build_on_save = true,
              inlay_hints_hide_redundant_param_names = true,
              warn_style = true,
            },
          })
        end,
      },
    })
  end,
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neoconf.nvim",
  },
}
