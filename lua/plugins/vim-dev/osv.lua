return {
  "jbyuki/one-small-step-for-vimkind",
  lazy = true,
  init = function()
    vim.api.nvim_create_user_command("OsvServer", function()
      require("osv").launch({ port = 8086 })
    end, {})
  end,
  dependencies = {
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
          },
        }

        dap.adapters.nlua = function(callback, config)
          vim.notify("Connecting to OSV server . . .")
          callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end
      end,
    },
  },
}
