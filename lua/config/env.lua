vim.g.vscode = vim.g.vscode ~= nil
vim.g.is_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

local venv_path = vim.fs.joinpath(vim.fn.getcwd(), ".venv")
if vim.fn.isdirectory(venv_path) == 1 then
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.PATH = string.format("%s/bin:%s", venv_path, vim.env.PATH)
  vim.env.VIRTUAL_ENV_PROMPT = "(.venv)"
end
