local source_file = debug.getinfo(1, "S").short_src
local source_dir = source_file:sub(1, #source_file - #vim.fs.basename(source_file) - 1)
local files = vim.split(vim.fn.glob(string.format("%s/**/*.lua", source_dir)), "\n")

for _, file in ipairs(files) do
  if file ~= source_file then
    -- We could use dofile, but require shows up in the startime graphs
    require("after." .. file:sub(#source_dir + 2, #file - 4))
  end
end
