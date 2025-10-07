return {
  "nvim-focus/focus.nvim",
  init = function()
    local ignore_filetypes = { "neo-tree", "OverseerList" }
    local force_enable_filetypes = { "fugitive" } -- Overrides ignore_buftypes
    local ignore_buftypes = { "nofile", "prompt", "popup" }

    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      callback = function(_)
        vim.b.focus_disable = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
      end,
      desc = "Disable focus autoresize for FileType",
    })
    vim.api.nvim_create_autocmd("WinEnter", {
      group = augroup,
      callback = function(_)
        vim.w.focus_disable = vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
          and not vim.tbl_contains(force_enable_filetypes, vim.bo.buftype)
      end,
      desc = "Disable focus autoresize for BufType",
    })
  end,
  opts = {
    ui = {
      cursorline = false,
      signcolumn = false,
    },
  },
}
