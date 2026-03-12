local leader = require("keymaps").leader

--- Checks if the string ends with a given suffix.
---@param suffix string The suffix
---@return boolean ends_with True if the string ends with suffix.
function string:endswith(suffix)
  return self:sub(-#suffix) == suffix
end

-- https://github.com/nvim-neotest/neotest
return {
  "nvim-neotest/neotest",
  config = function()
    require("neotest").setup({
      adapters = {
        -- require("neotest-rust"),
        require("rustaceanvim.neotest"),
        require("neotest.cmakeseer.ctest"),
        require("neotest.cmakeseer.gtest"),
        require("neotest-dotnet")({
          discovery_root = "solution",
        }),
        require("neotest-bash"),
        require("neotest-python"),
        require("neotest-busted")({
          busted_command = "/usr/local/bin/busted",
        }),
      },
    })
  end,
  keys = {
    {
      leader(leader("t")),
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Neotest summary",
    },
  },
  cmd = {
    "Neotest",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rouge8/neotest-rust",
    "Issafalcon/neotest-dotnet",
    {
      "alfaix/neotest-gtest",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap",
      },
    },
    { "rcasia/neotest-bash", submodules = false },
    "nvim-neotest/neotest-python",
    "nvim-neotest/nvim-nio",
    "MisanthropicBit/neotest-busted",
    "stevearc/overseer.nvim",
  },
}
