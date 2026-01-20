-- Set up venv if applicable
if vim.env.VIRTUAL_ENV == nil then
  local venv_path = vim.fs.joinpath(vim.fn.getcwd(), ".venv")
  if vim.fn.isdirectory(venv_path) == 1 then
    vim.notify("Python venv found; activating. . .")
    vim.env.VIRTUAL_ENV = venv_path
    vim.env.PATH = string.format("%s/bin:%s", venv_path, vim.env.PATH)
    vim.env.VIRTUAL_ENV_PROMPT = "(.venv)"
  end
end
