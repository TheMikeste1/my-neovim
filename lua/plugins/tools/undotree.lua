local FileUtilities = require("utilities.file_utilities")

return {
  "mbbill/undotree",
  init = function()
    -- <https://github.com/mbbill/undotree?tab=readme-ov-file#usage>
    if vim.fn.has("persistent_undo") == 1 then
      local target_path = vim.fn.expand("~/.undodir")

      -- Create the directory and any parent directories if the location does not exist.
      if not FileUtilities.is_directory(target_path) then
        vim.fn.mkdir(target_path, "p", tonumber("700", 8))
      end

      vim.g.undodir = target_path
      vim.g.undofile = true
    end
  end,
  keys = {
    {
      "<leader>u",
      "<cmd>:UndotreeToggle<CR>",
      desc = "Open undotree",
    },
  },
}
