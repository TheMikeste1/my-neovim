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
end, {
  nargs = "_",
  desc = "Clear a log file.",
  complete = function(ArgLead)
    local logs = get_log_names()
    local matches = {}
    local nonmatches = {}
    for _, name in ipairs(logs) do
      if vim.startswith(name, ArgLead) then
        table.insert(matches, name)
      else
        table.insert(nonmatches, name)
      end
    end

    return vim.list_extend(matches, nonmatches)
  end,
})

vim.api.nvim_create_user_command("OpenLog", function(opts)
  local args = opts.fargs
  if #args > 2 then
    vim.notify("OpenLog takes one to two parameters:\n\t:OpenLog <log_name> [mode]", vim.log.levels.ERROR)
    return
  end

  local log_name = args[1]
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

  local mode = args[2] ~= "" and args[2] or "float"
  if mode == "float" then
    -- Create a scratch buffer specifically for the floating window
    local buf = vim.api.nvim_create_buf(false, true)
    local width = vim.o.columns - 3
    local height = vim.o.lines - 2
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width)),
      row = math.floor((vim.o.lines - height)),
      style = "minimal",
      border = "rounded",
    })
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  elseif mode == "split" then
    vim.cmd("split " .. vim.fn.fnameescape(path))
  elseif mode == "vsplit" then
    vim.cmd("vsplit " .. vim.fn.fnameescape(path))
  elseif mode == "current" then
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  else
    vim.notify("Invalid argument for OpenLog. Modes: float, split, vsplit, or current", vim.log.levels.ERROR)
    return
  end
end, {
  nargs = "+",
  desc = "Opens a log file",
  complete = function(ArgLead, CmdLine)
    local command_parts = vim.split(CmdLine, " ")
    local possibilities = {}
    if #command_parts < 3 then
      possibilities = get_log_names()
    elseif #command_parts == 3 then
      possibilities = { "float", "split", "vsplit", "current" }
    end

    local matches = {}
    local nonmatches = {}
    for _, possiblity in ipairs(possibilities) do
      if vim.startswith(possiblity, ArgLead) then
        table.insert(matches, possiblity)
      else
        table.insert(nonmatches, possiblity)
      end
    end

    return vim.list_extend(matches, nonmatches)
  end,
})
