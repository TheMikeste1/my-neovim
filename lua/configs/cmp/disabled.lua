require("utilities.functions")

local mod = {}

function mod.sources()
  local cmp = require("cmp")
  cmp.setup.filetype({}, { completion = { enable = false } })
end

return mod
