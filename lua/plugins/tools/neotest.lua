local leader = require("keymaps").leader

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
        require("cmakeseer.neotest.ctest"),
        require("neotest-dotnet")({
          discovery_root = "solution",
        }),
        require("neotest-gtest").setup({
          is_test_file = function(file)
            local filename = string.match(file, "([^/]+)$")
            if
              not (
                filename:endswith(".c")
                or filename:endswith(".cpp")
                or filename:endswith(".cppm")
                or filename:endswith(".cc")
                or filename:endswith(".cxx")
                or filename:endswith(".c++")
              )
            then
              return false
            end

            if string.find(filename, "test") ~= nil or string.find(filename, "Test") ~= nil then
              return true
            end
          end,
        }),
        require("neotest-bash"),
        require("neotest-python"),
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
    "stevearc/overseer.nvim",
  },
}
