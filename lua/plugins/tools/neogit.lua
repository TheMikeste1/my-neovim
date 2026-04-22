local function git_branches()
  -- Returns a table of branch names (local + remote) trimmed of the leading "* "
  local raw = vim.fn.systemlist('git branch --all --format="%(refname:short)"')
  local result = {}
  for _, line in ipairs(raw) do
    line = line:gsub("^%s*%*%s*", "") -- strip the "* " marker for the current branch
    line = vim.trim(line)
    if line ~= "" then
      table.insert(result, line)
    end
  end
  return result
end

local function git_branch_complete(ArgLead, _, _)
  local candidates = git_branches()
  return vim.tbl_filter(function(b)
    return vim.startswith(b, ArgLead)
  end, candidates)
end

local function resolve_git_target(target)
  target = (target and target ~= "") and target or "develop"
  -- Check if local branch exists
  local handle = io.popen("git rev-parse --verify " .. target .. " 2>/dev/null")
  if handle == nil then
    vim.notify("Failed to verify target", vim.log.levels.ERROR)
    return target
  end

  local result = handle:read("*a")
  handle:close()

  if result == "" then
    return "origin/" .. target
  end

  -- At this point local branch exists. Check if remote branch exists.
  local remote = "origin/" .. target
  local remote_handle = io.popen("git rev-parse --verify " .. remote .. " 2>/dev/null")
  if remote_handle then
    local remote_result = remote_handle:read("*a")
    remote_handle:close()
    if remote_result ~= "" then
      -- Compare commits: see if remote is ahead of local
      local compare_cmd = string.format("git rev-list --left-right --count %s...%s 2>/dev/null", target, remote)
      local cmp_handle = io.popen(compare_cmd)
      if cmp_handle then
        local cmp_output = cmp_handle:read("*a")
        cmp_handle:close()
        local left, right = cmp_output:match("(%d+)%s+(%d+)")
        if left and right and tonumber(right) > 0 then
          -- Remote has commits not present locally; prefer remote
          return remote
        end
      end
    end
  end

  return target
end

return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required

    -- Only one of these is needed.
    "sindrets/diffview.nvim", -- optional

    -- For a custom log pager
    "m00qek/baleia.nvim", -- optional

    -- Only one of these is needed.
    "folke/snacks.nvim", -- optional
  },
  init = function()
    vim.api.nvim_create_user_command("NeogitCompare", function(opts)
      local target = resolve_git_target(opts.args)
      require("neogit").action("log", "log_current", {
        target .. "...HEAD",
        "--graph",
        "--cherry-mark",
        "--boundary",
        "--decorate",
      })()
    end, {
      nargs = "*",
      desc = "Compare two git revisions with Neogit (defaults target=HEAD)",
      complete = git_branch_complete, -- custom branch completion
    })

    vim.api.nvim_set_hl(0, "NeogitGraphPurple", { fg = "#c678dd" })
  end,
  cmd = "Neogit",
  opts = {
    graph_style = "unicode",
  },
}
