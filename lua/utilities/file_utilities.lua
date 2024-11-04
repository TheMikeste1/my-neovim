--- Checks if the given path is a directory.
--- @param path string The path to check.
--- @return boolean True if the path is a directory, false otherwise.
function IsDirectory(path)
  if type(path) ~= "string" then
    error("path must be a string")
  end

  return vim.fn.isdirectory(path) == 1
end
