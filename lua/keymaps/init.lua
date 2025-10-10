local M = {}

--- Creates a mapping with the leader key at the front.
---@param keys string The keys to follow the leader.
---@return string keys
function M.leader(keys)
  return "<leader>" .. keys
end

--- Creates a mapping with the local leader key at the front.
---@param keys string The keys to follow the leader.
---@return string keys
function M.local_leader(keys)
  return "<localleader>" .. keys
end

--- Creates a mapping with the movement leader key at the front.
---@param keys string The keys to follow the leader.
---@return string keys
function M.move_leader(keys)
  return vim.g.mapmoveleader .. keys
end

return M
