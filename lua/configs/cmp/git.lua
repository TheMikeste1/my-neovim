require("utilities.functions")

local mod = {}

function mod.sources()
  local cmp = require("cmp")

  local config = cmp.get_config()
  local file_sources = cmp.config.sources({
    { name = "git" },
  })
  local new_sources = TableConcat(config.sources, file_sources)
  config.sources = new_sources
  cmp.setup.filetype("gitcommit", config)
end

return mod
