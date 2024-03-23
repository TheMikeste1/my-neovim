return {
	"Shatur/neovim-tasks",
	depedencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
  opts = {
    default_params = {
      cmake = {
        dap_name = "codelldb"
      }
    },
    params_file = "neovim-tasks.json"
  }
}
