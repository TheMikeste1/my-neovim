--- Set up auto-save all on rename

local _FILE_PREFIX = "file://"
local _FILE_PREFIX_LEN = #_FILE_PREFIX

--- Actions to take after the default handlers.
---@param err lsp.ResponseError? An error if one occurred.
---@param result any The result of the action.
---@param _ lsp.HandlerContext The context for the response.
local function post_handle(err, result, _)
  if err == nil then
    vim
      .iter(result.changes)
      :map(function(file)
        return vim.fn.bufnr(file:sub(_FILE_PREFIX_LEN + 1))
      end)
      :filter(function(bufnr)
        return bufnr > 0
      end)
      :each(vim.schedule_wrap(function(bufnr)
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd.w({ mods = { silent = true } })
        end)
      end))
  end
end

local LspMethods = vim.lsp.protocol.Methods
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local id = args.data.client_id
    local client = vim.lsp.get_client_by_id(id)
    assert(client ~= nil)
    local original_handler = client.handlers[LspMethods.textDocument_rename]
    if original_handler ~= nil then
      client.handlers[LspMethods.textDocument_rename] = function(...)
        original_handler(...)
        post_handle(...)
      end
    end
  end,
})

if vim.lsp.handlers[LspMethods.textDocument_rename] ~= nil then
  local original_handler = vim.lsp.handlers[LspMethods.textDocument_rename]
  vim.lsp.handlers[LspMethods.textDocument_rename] = function(...)
    original_handler(...)
    post_handle(...)
  end
else
  vim.notify("No default LSP rename handler", vim.log.levels.WARN)
end
