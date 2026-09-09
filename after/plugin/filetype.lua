vim.filetype.add({
  extension = {
    codecompanion = "markdown",
    godot = "gdresource",
    service = "systemd",
    slice = "systemd",
    tpp = "cpp",
    xtce = "xml",
    xteds = "xml",
    base = "yaml",
    core = "yaml",
  },
  filename = {
    [".gersemirc"] = "yaml",
    [".local.bash_env"] = "bash",
    [".local.gitconfig"] = "gitconfig",
    ["fusesoc.conf"] = "toml",
  },
  pattern = {
    [".*/cmd_tlm/.+%.txt"] = "cosmos",
    [".*/openc3.*/plugin%.txt"] = "cosmos",
    [".*/openc3.*/.*%.txt"] = "cosmos",
  },
})
