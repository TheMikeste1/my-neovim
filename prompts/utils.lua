return {
  buffer_contents = function(args)
    local bufnr = args.context.bufnr
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local content_lines = vim.api.nvim_buf_get_lines(bufnr, 0, line_count, false)
    return table.concat(content_lines, "\n")
  end,
}
