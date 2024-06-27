-- <https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr>
local function on_enter(fallback)
	local cmp = require("cmp")
	if cmp.visible() and cmp.get_active_entry() then
		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
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

		return
	end

	fallback()
end

local function config()
	local cmp = require("cmp")
	cmp.types = require("cmp.types")
	local lspkind = require("lspkind")

	cmp.setup({
		enabled = function()
			return vim.api.nvim_get_option_value("buftype", {}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end,
		experimental = {
			ghost_text = true,
		},
		formatting = {
      expandable_indicator = true,
      fields = { 'abbr', 'kind', 'menu' },
			format = lspkind.cmp_format({
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
				},
				mode = "symbol_text",
				symbol_map = { Copilot = "" },
			}),
		},
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping(function()
				cmp.complete()
			end, { "i", "c" }),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<M-p>"] = cmp.mapping.scroll_docs(-4),
			["<M-n>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.abort(),
			["<TAB>"] = cmp.mapping(on_tab, { "i", "s", "c" }),
			["<CR>"] = cmp.mapping({
				i = on_enter,
				s = cmp.mapping.confirm({ select = false }),
				c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			}),
		}),
		preselect = cmp.PreselectMode.None,
		sources = cmp.config.sources({
			{ { name = "nvim_lsp_signature_help" } },
			{ name = "vsnip", max_item_count = 5 },
			{ name = "copilot" },
			{
				name = "omni",
				option = {
					disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
				},
			},
			{
				name = "nvim_lsp",
				entry_filter = function(entry)
					local kind = cmp.types.lsp.CompletionItemKind[entry:get_kind()]
					return kind ~= "Text"
				end,
			},
			-- {
			-- 	name = "doxygen",
			-- 	option = {
			-- 		trigger_characters = { "@" },
			-- 	},
			-- },
		}, {
			-- {
			-- 	name = "ctags",
			-- 	option = {
			-- 		executable = "ctags",
			-- 		trigger_characters = { "." },
			-- 		trigger_characters_ft = {},
			-- 	},
			-- },
			{ name = "treesitter", max_item_count = 5 },
		}, {
			{ name = "path", max_item_count = 5 },
			{ name = "buffer", max_item_count = 5 },
			-- { name = "dynamic" },
			-- { name = "cmp_yanky" },
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

	-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		completion = {
			autocomplete = false,
		},
		sources = cmp.config.sources({
			{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
			{ name = "path" },
			{ name = "nvim_lsp_document_symbol" },
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
	config = config,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{ "onsails/lspkind.nvim", lazy = true },
		"hrsh7th/cmp-omni",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			"hrsh7th/cmp-nvim-lua",
			ft = {
				"lua",
			},
		},
		-- "delphinus/cmp-ctags",
		{
			"paopaol/cmp-doxygen",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
		},
		"rcarriga/cmp-dap",
		"ray-x/cmp-treesitter",
		-- "chrisgrieser/cmp_yanky",
	},
}
