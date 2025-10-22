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
  },
})
