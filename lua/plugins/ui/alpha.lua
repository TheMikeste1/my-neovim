local function open_session()
  local cwd = vim.loop.cwd()
  if cwd then
    local session = require("session_manager.config").dir_to_session_filename(cwd)
    if session:exists() then
      require("session_manager").load_current_dir_session(true)
    else
      print("No session found for " .. cwd)
    end
  else
    print("Cannot load session; no cwd found")
  end
end

local function generate_dashboard()
  local screen = require("alpha.themes.theta")
  local dashboard = require("alpha.themes.dashboard")

  screen.leader = "\\"
  screen.buttons.val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    dashboard.button("e", "  New file", "<cmd>enew<CR>"),
    dashboard.button("<C-p>", "󰈞  Find file"),
    dashboard.button("<M-C-F>", "󰊄  Live grep"),
    dashboard.button("s", "  Open last session", open_session),
    dashboard.button("c", "  Configuration", function()
      local dir = vim.fn.stdpath("config")
      vim.cmd.tcd(dir)
      vim.notify(string.format("Tab changed directory to %s", dir))
    end),
    dashboard.button("p", "󰚥  Plugin Folder", function()
      local dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      vim.cmd.tcd(dir)
      vim.notify(string.format("Tab changed directory to %s", dir))
    end),
    dashboard.button("t", "  Open terminal", "<cmd>terminal<CR>"),
    dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
    dashboard.button("q", "󰅚  Quit", "<cmd>q<CR>"),
  }
  return screen.config
end

return {
  "goolord/alpha-nvim",
  cond = false,
  init = function()
    vim.api.nvim_create_autocmd("TabNewEntered", {
      group = vim.api.nvim_create_augroup("default_tab", {}),
      desc = "Open Alpha on new, empty tab",
      pattern = "*",
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if filename == "" then
          vim.cmd("Alpha")
        end
      end,
    })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  opts = generate_dashboard,
}
