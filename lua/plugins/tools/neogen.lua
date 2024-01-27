return {
  "danymat/neogen",
  cond = true,
  config = function()
    require("neogen").setup({
      snippet_engine = "nvim",
      languages = {
        ["gdscript"] = require("neogen.configurations.gdscript"),
      },
    })
  end,
  dependencies = {
    {
      "TheMikeste1/neogen-gdscript",
      cond = true,
    },
  },
}
