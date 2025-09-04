require("utilities.state")

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

  vim.keymap.del("n", "gra")
  vim.keymap.del("n", "gri")
  vim.keymap.del("n", "grn")
  vim.keymap.del("n", "grr")
  vim.keymap.del("n", "grt")
  vim.keymap.del("x", "gra")

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local Snacks = require("snacks")
      local telescope_builtin = require("telescope.builtin")

      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set("n", "K", hover, { buffer = ev.buf, desc = "Hover info" })
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
      vim.keymap.set(
        "n",
        "<space>D",
        Snacks.picker.lsp_type_definitions,
        { buffer = ev.buf, desc = "List LSP type definition" }
      )
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename variable" })

      vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { buffer = ev.buf, desc = "Go to declaration" })
      vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { buffer = ev.buf, desc = "Go to definition" })
      vim.keymap.set("n", "gr", Snacks.picker.lsp_references, { buffer = ev.buf, desc = "List LSP references" })
      vim.keymap.set(
        "n",
        "gi",
        Snacks.picker.lsp_implementations,
        { buffer = ev.buf, desc = "List LSP implementations" }
      )
      vim.keymap.set("n", "<M-C-O>", function()
        Snacks.picker.lsp_symbols({ filter = { default = true } })
      end, { buffer = ev.buf, desc = "List LSP current file symbols" })
      vim.keymap.set(
        "n",
        "<M-C-I>",
        Snacks.picker.lsp_workspace_symbols,
        { buffer = ev.buf, desc = "List LSP workspace symbols" }
      )
      vim.keymap.set(
        "n",
        "gci",
        telescope_builtin.lsp_incoming_calls,
        { buffer = ev.buf, desc = "List LSP incoming calls" }
      )
      vim.keymap.set(
        "n",
        "gco",
        telescope_builtin.lsp_outgoing_calls,
        { buffer = ev.buf, desc = "List LSP outgoing calls" }
      )
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  config = config,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "nvim-telescope/telescope.nvim",
  },
}
