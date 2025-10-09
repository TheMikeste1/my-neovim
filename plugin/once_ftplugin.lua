local source_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "core_ext", "once_ftplugin")
local files = vim.split(vim.fn.glob(string.format("%s/**/*.lua", source_dir)), "\n")

for _, file in ipairs(files) do
  local filetype = file:sub(#source_dir + 2, #file - 4)
  vim.api.nvim_create_autocmd("FileType", {
    desc = string.format("Run the one-time filetype setup for %s files", filetype),
    pattern = filetype,
    once = true,
    callback = function()
      require("core_ext.once_ftplugin." .. filetype)
    end,
  })
end
