-- TODO: Look at blink.cmp
local function format(entry, vim_item)
  return require("lspkind").cmp_format({
    ellipsis_char = "...",
    maxwidth = 50,
    menu = {
      copilot = "[Copilot]",
      async_path = "[Path]",
      buffer = "[Buffer]",
      bufferlines = "[BufferLine]",
      ctags = "[CTags]",
      doxygen = "[Doxygen]",
      dynamic = "[Dynamic]",
      nvim_lsp = "[LSP]",
      nvim_lsp_document_symbol = "[DocSymbol]",
      nvim_lua = "[NVim]",
      omni = "[Omni]",
      spell = "[Spell]",
      treesitter = "[Tree]",
      vsnip = "[Snip]",
      snippets = "[Snip]",
    },
    mode = "symbol",
    symbol_map = { Copilot = "" },
  })(entry, vim_item)
end

-- <https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr>
local function on_enter(fallback)
  local cmp = require("cmp")
  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
  else
    fallback()
  end
end

-- <https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#intellij-like-mapping>
local function on_tab(fallback)
  local cmp = require("cmp")
  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  if cmp.visible() then
    local entry = cmp.get_selected_entry()
    if not entry then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    else
      cmp.confirm()
    end
  elseif vim.snippet.active({ direction = 1 }) then
    vim.schedule(function()
      vim.snippet.jump(1)
    end)
  else
    fallback()
  end
end

local function on_back_tab(fallback)
  local cmp = require("cmp")
  -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  if cmp.visible() then
    local entry = cmp.get_selected_entry()
    if not entry then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    else
      cmp.confirm()
    end
  elseif vim.snippet.active({ direction = -1 }) then
    vim.schedule(function()
      vim.snippet.jump(-1)
    end)
  else
    fallback()
  end
end

local function config()
  local cmp = require("cmp")
  cmp.types = require("cmp.types")

  cmp.setup({
    enabled = function()
      -- If we're in a prompt (but not a DAP prompt)
      if vim.api.nvim_get_option_value("buftype", {}) == "prompt" and not require("cmp_dap").is_dap_buffer() then
        return false
      end

      -- If we're in the command window (press `q:` in normal mode)
      if vim.fn.getcmdwintype() ~= "" then
        return false
      end

      return true
    end,
    experimental = {
      -- TODO: Checkout https://neovim.io/doc/user/lsp.html#lsp-inline_completion
      ghost_text = true,
    },
    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind", "menu" },
      format = format,
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(item)
        local snippet = item.body
        -- <https://github.com/LazyVim/LazyVim/blob/a1c3ec4cd43fe61e3b614237a46ac92771191c81/lua/lazyvim/util/cmp.lua#L101>
        local session = vim.snippet.active() and vim.snippet._session or nil
        local ok, err = pcall(vim.snippet.expand, snippet)
        if not ok then
          vim.notify("Snippet failed to expand: " .. err)
        end
        -- Restore top-level session when needed
        if session then
          vim.snippet._session = session
        end
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping(function()
        cmp.complete()
      end, { "i" }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<M-p>"] = cmp.mapping.scroll_docs(-4),
      ["<M-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<TAB>"] = cmp.mapping(on_tab, { "i", "s", c = cmp.config.disable }),
      ["<S-TAB>"] = cmp.mapping(on_back_tab, { "i", "s", c = cmp.config.disable }),
      ["<CR>"] = cmp.mapping({
        i = on_enter,
        s = cmp.mapping.confirm({ select = false }),
        c = cmp.config.disable,
        -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      }),
    }),
    preselect = cmp.PreselectMode.None,
    sources = cmp.config.sources({
      { { name = "nvim_lsp_signature_help" } },
      { name = "snippets", max_item_count = 5 },
      {
        name = "nvim_lsp",
        entry_filter = function(entry)
          local kind = cmp.types.lsp.CompletionItemKind[entry:get_kind()]
          return kind ~= "Text"
        end,
      },
    }, {
      { name = "treesitter", max_item_count = 5 },
    }, {
      { name = "path", max_item_count = 5 },
      { name = "buffer", max_item_count = 5 },
    }),
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
      { name = "buffer" },
    }),
  })

  require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })

  -- require("configs.cmp.dap").sources()
  require("configs.cmp.disabled").sources()
  require("configs.cmp.lua").sources()
end

return {
  "hrsh7th/nvim-cmp",
  init = function()
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  end,
  config = config,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "onsails/lspkind.nvim", lazy = true },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    {
      "hrsh7th/cmp-nvim-lua",
      ft = {
        "lua",
      },
    },
    "rcarriga/cmp-dap",
    "ray-x/cmp-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
