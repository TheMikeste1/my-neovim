local function autosave()
  -- Auto save session
  vim.api.nvim_create_autocmd({ "BufWritePre", "VimSuspend" }, {
    callback = function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Don't save while there's any 'nofile' buffer open.
        if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
          return
        end
      end
      local session_manager = require("session_manager")
      session_manager.save_current_session()
    end,
  })
end

local function autoload()
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      if vim.fn.argc() == 0 then
        -- Do nothing if no file is provided; relay on the dashboard
        return
      end

      -- If a file is provided, don't load the session
      -- However, load the session if a directory is provided
      local FileUtilities = require("utilities.file_utilities")
      if not FileUtilities.isDirectory(vim.fn.expand("%:p:h")) then
        return
      end

      require("session_manager").load_current_dir_session(true)
    end,
  })
end

local function configure()
  local Path = require("plenary.path")
  local config = require("session_manager.config")
  require("session_manager").setup({
    sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
    session_filename_to_dir = nil, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
    dir_to_session_filename = nil, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
    autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
    autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
      "gitcommit",
      "gitrebase",
    },
    autosave_ignore_buftypes = {}, -- All buffers of these buffer types will be closed before the session is saved.
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
  })
end

return {
  "Shatur/neovim-session-manager",
  config = function()
    configure()
    autosave()
    -- autoload()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
