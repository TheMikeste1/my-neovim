-- Recompile spell file if it updated
local paths = vim.split(vim.fn.glob(vim.fs.joinpath(vim.fn.stdpath("config"), "spell", "/*.add")), "\n")
for _, file in ipairs(paths) do
  -- Can we skip generation?
  local compiled_file = file .. ".spl"
  if vim.fn.filereadable(compiled_file) == 1 then
    local file_timestamp = vim.fn.getftime(file)
    local compiled_timestamp = vim.fn.getftime(compiled_file)
    if file_timestamp <= compiled_timestamp then
      goto continue
    end
  end

  vim.notify(string.format("Regenerating spell file %s. . .", vim.fs.basename(file)))
  vim.cmd("mkspell! " .. file)
  ::continue::
end
