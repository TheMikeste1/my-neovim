-- https://www.lua.org/pil/11.5.html

local M = {}

---@class Set<T>: { [T]: boolean }

--- Creates a new Set.
---@generic T
---@param list T[] The list to turn into the set.
---@return Set<T>
function M.Set(list)
  ---@generic T
  ---@type Set<T>
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set
end

return M
