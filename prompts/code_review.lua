return {
  diff = function(args)
    _ = args

    local result = vim.system({ "git", "symbolic-ref", "refs/remotes/origin/HEAD" }, { text = true }):wait()
    local default_branch = vim.trim(result.stdout or ""):gsub("^refs/remotes/origin/", "")
    local branch = vim.fn.input({ prompt = "To which branch are you merging?", default = default_branch })
    if branch == "" then
      return "User canceled request"
    end

    local target = "origin/" .. branch
    local merge_base = vim.system({ "git", "merge-base", "HEAD", target }):wait()
    local base = vim.trim(merge_base.stdout or "")
    if not base or base == "" then
      local stderr = merge_base.stderr
      return "Failed to determine merge base: " .. (stderr or "unknown error")
    end

    local diff_call = vim.system({ "git", "diff", base }):wait()
    local diff = diff_call.stdout
    if diff == nil then
      local stderr = diff_call.stderr
      return "Failed to retrieve diff: " .. (stderr or "unknown error")
    end

    diff = diff:gsub("```", "\\`\\`\\`")
    return diff
  end,
}
