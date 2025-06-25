vim.lsp.config("*", {
  root_markers = { ".git", ".hg" },
})

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
