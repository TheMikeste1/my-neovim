local function get_log_names()
  local log_path = vim.fn.stdpath("log")
  local logs = {}
  for filename, type in vim.fs.dir(log_path) do
    if type == "file" then
      local log_name = vim.fn.fnamemodify(filename, ":r")
      table.insert(logs, log_name)
    end
  end
  return logs
end

local function get_log_names_as_string()
  local logs = get_log_names()
  if #logs == 0 then
    return nil
  end

  local logs_string = logs[1]
  for i = 2, #logs do
    local log = logs[i]
    logs_string = logs_string .. ", " .. log
  end
  return logs_string
end

vim.api.nvim_create_user_command("ClearLog", function(opts)
  local log_name = opts.args
  if log_name == nil then
    local logs_string = get_log_names_as_string()
    if logs_string == nil then
      vim.notify("No logs available!", vim.log.levels.WARN)
    else
      vim.notify("Provide a log to clear. Options: " .. logs_string, vim.log.levels.ERROR)
    end

    return
  end

  local path = vim.fs.joinpath(vim.fn.stdpath("log"), log_name) .. ".log"
  if not vim.uv.fs_stat(path) then
    local logs_string = get_log_names_as_string()
    if logs_string == nil then
      vim.notify("No logs available!", vim.log.levels.WARN)
    else
      vim.notify("Invalid log `" .. log_name .. "`. Options: " .. logs_string, vim.log.levels.ERROR)
    end

    return
  end

  local file = io.open(path, "w")
  if file then
    file:close()
    vim.notify("Log " .. log_name .. " cleared successfully.")
  else
    vim.notify(string.format("Error: Could not open %s.", path))
  end
end, { nargs = "_", desc = "Clear a log file." })

-- TODO: Open log  command like ConformLog
