vim.lsp.config("*", {
  root_markers = { ".git", ".hg" },
})

---@param tools string[]
function get_missing_masons(tools)
  local installed_tools = {}
  for _, packages in ipairs(require("mason-registry").get_installed_packages()) do
    for _, tool in ipairs(tools) do
      if packages.spec.name == tool then
        table.insert(installed_tools, tool)
        goto continue
      end
    end
    ::continue::
  end

  return vim.tbl_filter(function(tool)
    return not vim.tbl_contains(installed_tools, tool)
  end, tools)
end

local MASON_TOOLS = {
  ["global"] = { "editorconfig-checker", "harper-ls" },
  -- TODO: Fill out remaining tools for each file type/language, check which are installed for each type, and create a command to install all tools as needed.
}

