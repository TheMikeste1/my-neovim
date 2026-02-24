return {
  diff = function(args)
    _ = args
    local branch = vim.fn.input({ prompt = "To which branch are you merging?", default = "develop" })
    if branch == "" then
      return "User canceled request"
    end

    local diff_call = vim.system({ "git", "diff", ("origin/%s"):format(branch) }):wait()
    local diff = diff_call.stdout
    if diff == nil then
      local stderr = vim.inspect(diff_call.stderr)
      return "Failed to retrieve diff: " .. vim.inspect(stderr)
    end

    diff = diff:gsub("```", "\\`\\`\\`")
    return diff
  end,
}
