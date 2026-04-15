--- Copies the current buffer's file path to a Vim register.
---
--- Supports copying either the absolute path or just the file name depending on the bang flag.
---
--- @param opts table Options table provided by the user command.
---   - `args` (string) Optional register name; if omitted the unnamed register is used.
---   - `bang` (boolean) When true, only the file name (``:t``) is copied; otherwise the full path (``:p``).
--- @usage
---   :CopyPath          " copies the absolute path to the unnamed register
---   :CopyPath a        " copies the absolute path to register 'a'
---   :CopyPath!         " copies just the file name to the unnamed register
---   :CopyPath! b       " copies just the file name to register 'b'
local function copy_file_path(opts)
  local reg = (opts.args ~= "" and opts.args) or '"'
  local path = vim.api.nvim_buf_get_name(0)
  if not opts.bang then
    path = vim.fn.fnamemodify(path, ":p")
  else
    path = vim.fn.fnamemodify(path, ":t")
  end

  vim.fn.setreg(reg, path)
  if reg == '"' then
    ---@type string[]
    ---@diagnostic disable-next-line: undefined-field
    local clipboard = vim.opt.clipboard:get()
    if vim.list_contains(clipboard, "unnamed") then
      vim.fn.setreg("*", path)
      reg = reg .. " and *"
    end
    if vim.list_contains(clipboard, "unnamedplus") then
      vim.fn.setreg("+", path)
      reg = reg .. " and +"
    end
  end

  vim.notify(string.format("Copied to register %s: %s", reg, path))
end

vim.api.nvim_create_user_command("CopyPath", copy_file_path, { nargs = "?", bang = true })
