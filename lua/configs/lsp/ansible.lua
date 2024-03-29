local mod = {}

function mod.setup()
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	lspconfig.ansiblels.setup({
		capabilities = capabilities,
	})
end

return mod
