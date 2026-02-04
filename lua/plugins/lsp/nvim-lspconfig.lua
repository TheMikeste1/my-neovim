local leader = require("keymaps").leader
local rapid_leader = require("keymaps").rapid_leader

local function hover()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end

local function config()
  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set("n", leader("e"), vim.diagnostic.open_float, { desc = "Open float" })
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
    callback = function(event)
      local Snacks = require("snacks")
      local telescope_builtin = require("telescope.builtin")

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set("n", leader(leader("i")), function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle inlay hints" })
      vim.keymap.set("n", "K", hover, { buffer = event.buf, desc = "Hover info" })
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Get signature help" })
      vim.keymap.set(
        "n",
        "<space>D",
        Snacks.picker.lsp_type_definitions,
        { buffer = event.buf, desc = "List LSP type definition" }
      )
      vim.keymap.set("n", rapid_leader("rn"), vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename variable" })

      vim.keymap.set("n", "gD", Snacks.picker.lsp_declarations, { buffer = event.buf, desc = "Go to declaration" })
      vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { buffer = event.buf, desc = "Go to definition" })
      vim.keymap.set("n", "gr", Snacks.picker.lsp_references, { buffer = event.buf, desc = "List LSP references" })
      vim.keymap.set(
        "n",
        "gi",
        Snacks.picker.lsp_implementations,
        { buffer = event.buf, desc = "List LSP implementations" }
      )
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
        telescope_builtin.lsp_incoming_calls,
        { buffer = event.buf, desc = "List LSP incoming calls" }
      )
      vim.keymap.set(
        "n",
        "glo",
        telescope_builtin.lsp_outgoing_calls,
        { buffer = event.buf, desc = "List LSP outgoing calls" }
      )

      local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
      if client:supports_method("textDocument/codeLens") then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          group = vim.api.nvim_create_augroup("lsp." .. client.name, { clear = false }),
          buffer = event.buf,
          callback = function(args)
            vim.lsp.codelens.enable(true, { bufnr = args.buf })
          end,
        })
      end
      -- TODO: Check out https://neovim.io/doc/user/lsp.html#lsp-linked_editing_range
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  -- event = "VeryLazy", -- Launching on VeryLazy seems to cause issues with some filetypes
  config = config,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "nvim-telescope/telescope.nvim",
  },
}
