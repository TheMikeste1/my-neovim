local M = {}

--- Checks if a path is the Windows form of a WSL path.
---@param path string The path to check.
---@return boolean value If the path is a Windows form of a WSL path.
function M.is_wsl_path_as_windows(path)
  return path.sub(0, 5) == "\\\\wsl"
end

--- Checks if a path is the Windows form of a WSL path.
---@param path string The path to check.
---@return boolean value If the path is a Windows form of a WSL path.
function M.is_windows_path(path)
  return path.sub(0, 5) == "\\\\wsl" or path.sub(0, 1) ~= "\\"
end

--- Checks if the given path is a directory.
--- @param path string The path to check.
--- @return boolean value if the path is a directory.
function M.is_directory(path)
  if type(path) ~= "string" then
    error("path must be a string")
  end

  return vim.fn.isdirectory(path) == 1
end

--- Changes a WSL path to its associated Windows path.
---@param path string The path to check.
---@return string path The path as a Windows path.
function M.wsl_path_to_windows(path)
  local sys_call_result = vim.system({ "wslpath", "-w", path }, { text = true }):wait()
  path = sys_call_result.stdout
  assert(path ~= nil, "Did not get output from wslpath")
  path = path:sub(0, #path - 1)
  return path
end

--- Changes a Windows path to its associated WSL path.
---@param path string The path to check.
---@return string path The path as a Windows path.
function M.windows_path_to_wsl(path)
  local sys_call_result = vim.system({ "wslpath", "-u", path }, { text = true }):wait()
  path = sys_call_result.stdout
  assert(path ~= nil, "Did not get output from wslpath")
  path = path:sub(0, #path - 1)
  return path
end

--- Checks if a path is on WSL.
---@param path string The path to check.
---@return boolean result True if the path is on WSL.
function M.path_is_wsl(path)
  if vim.g.is_wsl then
    local result = M.wsl_path_to_windows(path)
    return M.is_wsl_path_as_windows(result)
  end
  return false
end

--- Checks if a path is on WSL or Windows, returning the appropriate form.
---@param path string The path to check.
---@return string path The path either as a Linux path or as a Windows path
function M.os_path(path)
  if vim.g.is_wsl then
    if M.is_windows_path(path) then
      if M.is_wsl_path_as_windows(path) then
        -- It's a WSL path in Windows form
        return M.windows_path_to_wsl(path)
      end

      -- We're operating on a Windows path on Windows
      return path
    end

    -- We're on a WSL path
    local maybe_windows_path = M.wsl_path_to_windows(path)
    if M.is_wsl_path_as_windows(maybe_windows_path) then
      -- We're still on WSL
      return path
    end

    -- We're actually on Windows
    return maybe_windows_path
  end
  return path
end

return M
