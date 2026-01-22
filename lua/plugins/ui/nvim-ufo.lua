-- Source: <https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text>
local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂%d … "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  init = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    require("ufo").setup({
      fold_virt_text_handler = fold_virt_text_handler,
      provider_selector = function(bufnr, filetype, buftype)
        if filetype == "markdown" then
          return { "treesitter" }
        end
        return { "treesitter", "indent" }
      end,
    })
    vim.lsp.config("*", {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "codecompanion" },
      callback = function()
        vim.b.ufo_ft_keywords = {
          "atx_heading",
          "setext_heading",
          "fenced_code_block",
          "yaml_front_matter",
        }
      end,
    })
  end,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Load the LSP capabilities first so we override them in config
    "kevinhwang91/promise-async",
  },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Open all folds",
    },
  },
}
