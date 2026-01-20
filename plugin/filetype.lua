vim.filetype.add({
  extension = {
    godot = "gdresource",
    service = "systemd",
    slice = "systemd",
    tpp = "cpp",
    xteds = "xml",
    base = "yaml",
  },
  filename = {
    [".local.gitconfig"] = "gitconfig",
    [".local.bash_env"] = "bash",
  },
  pattern = {
    [".*/cmd_tlm/.+%.txt"] = "cosmos",
    [".*/openc3.*/plugin%.txt"] = "cosmos",
    [".*/openc3.*/.*%.txt"] = "cosmos",
  },
})
