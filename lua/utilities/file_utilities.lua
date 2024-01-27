local M = {}

--- Checks if a path is the Windows form of a WSL path.
---@param path string The path to check.
---@return boolean value If the path is a Windows form of a WSL path.
function M.isWSLPathAsWindows(path)
  return path.sub(0, 5) == "\\\\wsl"
end

--- Checks if a path is the Windows form of a WSL path.
---@param path string The path to check.
---@return boolean value If the path is a Windows form of a WSL path.
function M.isWindowsPath(path)
  return path.sub(0, 5) == "\\\\wsl" or path.sub(0, 1) ~= "\\"
end

--- Checks if the given path is a directory.
--- @param path string The path to check.
--- @return boolean value if the path is a directory.
function M.isDirectory(path)
  if type(path) ~= "string" then
    error("path must be a string")
  end

  return vim.fn.isdirectory(path) == 1
end

--- Changes a WSL path to its associated Windows path.
---@param path string The path to check.
---@return string path The path as a Windows path.
function M.wslPathToWindows(path)
  local sys_call_result = vim.system({ "wslpath", "-w", path }, { text = true }):wait()
  path = sys_call_result.stdout
  assert(path ~= nil, "Did not get output from wslpath")
  path = path:sub(0, #path - 1)
  return path
end

--- Changes a Windows path to its associated WSL  path.
---@param path string The path to check.
---@return string path The path as a Windows path.
function M.windowsPathToWSL(path)
  local sys_call_result = vim.system({ "wslpath", "-u", path }, { text = true }):wait()
  path = sys_call_result.stdout
  assert(path ~= nil, "Did not get output from wslpath")
  path = path:sub(0, #path - 1)
  return path
end

--- Checks if a path is on WSL.
---@param path string The path to check.
---@return boolean result True if the path is on WSL.
function M.pathIsWSL(path)
  if IS_WSL then
    local result = M.wslPathToWindows(path)
    return M.isWSLPathAsWindows(result)
  end
  return false
end

--- Checks if a path is on WSL or Windows, returning the appropriate form.
---@param path string The path to check.
---@return string path The path either as a Linux path or as a Windows path
function M.osPath(path)
  if IS_WSL then
    if M.isWindowsPath(path) then
      if M.isWSLPathAsWindows(path) then
        -- It's a WSL path in Windows form
        return M.windowsPathToWSL(path)
      end

      -- We're operating on a Windows path on Windows
      return path
    end

    -- We're on a WSL path
    local maybe_windows_path = M.wslPathToWindows(path)
    if M.isWSLPathAsWindows(maybe_windows_path) then
      -- We're still on WSL
      return path
    end

    -- We're actually on Windows
    return maybe_windows_path
  end
  return path
end

return M
