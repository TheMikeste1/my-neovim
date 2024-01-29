return {
	"ggandor/leap-spooky.nvim",
	cond = true,
  config = function()
    require("leap-spooky").setup()
  end,
	dependencies = {
		"ggandor/leap.nvim",
	},
}

