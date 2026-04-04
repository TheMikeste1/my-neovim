local Snacks = require("snacks")
local leader = require("keymaps").leader
local rapid_leader = require("keymaps").rapid_leader

local function hover()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end

local function deprecate_keybind(mode, old_bind, new_bind)
  vim.keymap.set(mode, old_bind, function()
    vim.notify(string.format("%s is deprecated, use %s instead", old_bind, new_bind), vim.log.levels.WARN)
  end)
end

vim.lsp.codelens.enable(true)
vim.lsp.linked_editing_range.enable(true)
vim.lsp.document_color.enable(true)
vim.lsp.semantic_tokens.enable(true)

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", leader("e"), vim.diagnostic.open_float, { desc = "Open float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

vim.keymap.set("n", "gri", Snacks.picker.lsp_implementations, { desc = "List LSP implementations" })
vim.keymap.set("n", "grr", Snacks.picker.lsp_references, { desc = "List LSP references" })
vim.keymap.set("n", "grt", Snacks.picker.lsp_type_definitions, { desc = "List LSP type definition" })
vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { desc = "Go to declaration" })
vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "Go to definition" })

deprecate_keybind("n", "gi", "gri")
deprecate_keybind("n", rapid_leader("rn"), "grn")
deprecate_keybind("n", "<space>D", "grt")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", leader(leader("i")), function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle inlay hints" })
    vim.keymap.set("n", "K", hover, { buffer = event.buf, desc = "Hover info" })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Get signature help" })

    vim.keymap.set("n", "<M-C-O>", function()
      Snacks.picker.lsp_symbols({ filter = { default = true } })
    end, { buffer = event.buf, desc = "List LSP current file symbols" })
    vim.keymap.set(
      "n",
      "<M-C-I>",
      Snacks.picker.lsp_workspace_symbols,
      { buffer = event.buf, desc = "List LSP workspace symbols" }
    )
    vim.keymap.set(
      "n",
      "gli",
      Snacks.picker.lsp_incoming_calls,
      { buffer = event.buf, desc = "List LSP incoming calls" }
    )
    vim.keymap.set(
      "n",
      "glo",
      Snacks.picker.lsp_outgoing_calls,
      { buffer = event.buf, desc = "List LSP outgoing calls" }
    )
  end,
})
