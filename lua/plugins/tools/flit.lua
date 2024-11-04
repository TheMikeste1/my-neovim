return {
  "ggandor/flit.nvim",
  cond = true,
  config = function()
    local safe_labels = "fnut/SFNLHMUGTZ?"
    local labels = "fnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?"

    local safe_labels_table = {}
    local labels_table = {}

    for v in string.gmatch(safe_labels, "%a") do
      safe_labels_table[#safe_labels_table + 1] = v
    end
    for v in string.gmatch(labels, "%a") do
      labels_table[#labels_table + 1] = v
    end

    require("flit").setup({
      labeled_modes = "vn",
      opts = {
        safe_labels = safe_labels_table,
        labels = labels_table,
      },
    })
  end,
  dependencies = {
    "ggandor/leap.nvim",
    "tpope/vim-repeat",
  },
}
