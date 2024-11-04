local function hover()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end

local function config()
  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open float" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set location list" })

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
      vim.keymap.set("n", "K", hover, { buffer = ev.buf, desc = "Hover info" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Get signature help" })
      vim.keymap.set(
        "n",
        "<space>wa",
        vim.lsp.buf.add_workspace_folder,
        { buffer = ev.buf, desc = "Add workspace folder" }
      )
      vim.keymap.set(
        "n",
        "<space>wr",
        vim.lsp.buf.remove_workspace_folder,
        { buffer = ev.buf, desc = "Remove workspace folder" }
      )
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, { buffer = ev.buf, desc = "List workspace folders" })
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Lookup type definition" })
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename variable" })
      vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references()
      end, { buffer = ev.buf, desc = "List LSP references" })
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
