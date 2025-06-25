vim.lsp.config("*", {
  root_markers = { ".git", ".hg" },
})

---@param tools string[]
function get_missing_masons(tools)
  local installed_tools = {}
  for _, packages in ipairs(require("mason-registry").get_installed_packages()) do
    for _, tool in ipairs(tools) do
      if packages.spec.name == tool then
        table.insert(installed_tools, tool)
        goto continue
      end
    end
    ::continue::
  end

  return vim.tbl_filter(function(tool)
    return not vim.tbl_contains(installed_tools, tool)
  end, tools)
end

local MASON_TOOLS = {
  ["global"] = { "editorconfig-checker", "harper-ls" },
  -- TODO: Fill out remaining tools for each file type/language, check which are installed for each type, and create a command to install all tools as needed.
}

-- Set up auto-save all on rename
local LspMethods = require("vim.lsp.protocol").Methods
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local id = args.data.client_id
    local client = vim.lsp.get_client_by_id(id)
    assert(client ~= nil)
    local original_handler = client.handlers[LspMethods.textDocument_rename]
    if original_handler ~= nil then
      client.handlers[LspMethods.textDocument_rename] = function(err, result, ctx)
        original_handler(err, result, ctx)
        if err == nil then
          vim.api.nvim_buf_call(ctx.bufnr, function()
            vim.cmd.w({ mods = { silent = true } })
          end)
        end
      end
    end
  end,
})

if vim.lsp.handlers[LspMethods.textDocument_rename] ~= nil then
  local original_handler = vim.lsp.handlers[LspMethods.textDocument_rename]
  vim.lsp.handlers[LspMethods.textDocument_rename] = function(err, result, ctx)
    original_handler(err, result, ctx)
    if err == nil then
      vim.api.nvim_buf_call(ctx.bufnr, function()
        vim.cmd.w({ mods = { silent = true } })
      end)
    end
  end
else
  vim.notify("No default LSP rename handler", vim.log.levels.WARN)
end
