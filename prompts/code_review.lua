return {
  diff = function(args)
    _ = args
    local branch = vim.fn.input({ prompt = "To which branch are you merging?", default = "develop" })
    if branch == "" then
      return "User canceled request"
    end

    return vim.system({ "git", "diff", ("origin/%s"):format(branch) }):wait().stdout
  end,
}
