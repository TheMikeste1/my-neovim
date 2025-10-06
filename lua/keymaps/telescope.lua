local mod = {}

-- Send the selected entry to the quickfix list and open the list.
-- @param prompt_buffer_number number: The prompt buffer number.
local function send_to_quickfix_list(prompt_buffer_number)
  require("telescope.actions").smart_send_to_qflist(prompt_buffer_number)
  require("snacks").picker.qflist()
end

mod.mappings = {
  i = {
    ["<M-C-q>"] = send_to_quickfix_list,
  },
  n = {
    ["<M-C-q>"] = send_to_quickfix_list,
  },
}

mod.lazy_keys = {}

return mod
