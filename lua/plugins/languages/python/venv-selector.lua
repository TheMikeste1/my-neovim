return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    dap_enabled = true,
    name = { "venv", ".venv" },
  },
  -- config = function(_, opts)
  -- vim.api.nvim_create_autocmd("VimEnter", {
  -- 	desc = "Auto select virtualenv Nvim open",
  -- 	pattern = "*.py",
  -- 	callback = function()
  -- 		local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
  -- 		if venv ~= "" then
  -- 			require("venv-selector").retrieve_from_cache()
  -- 			return
  -- 		end
  --
  -- 		venv = vim.fn.finddir("venv", vim.fn.getcwd() .. ";")
  -- 		if venv ~= "" then
  -- 			require("venv-selector").retrieve_from_cache()
  -- 			return
  -- 		end
  --
  -- 		venv = vim.fn.finddir(".venv", vim.fn.getcwd() .. ";")
  -- 		if venv ~= "" then
  -- 			require("venv-selector").retrieve_from_cache()
  -- 			return
  -- 		end
  -- 	end,
  -- 	once = true,
  -- })
  -- end,
  -- keys = {
  -- 	-- Keymap to open VenvSelector to pick a venv.
  -- 	{ "<leader>vs", "<cmd>VenvSelect<cr>" },
  -- 	-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
  -- 	{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  --  },
  event = "VeryLazy",
  cmd = {
    "VenvSelect",
    "VenvSelectCached",
    "VenvSelectCurrent",
  },
}
