vim.filetype.add({
  extension = {
    base = "yaml",
    codecompanion = "markdown",
    core = "yaml",
    godot = "gdresource",
    plantuml = "plantuml",
    puml = "plantuml",
    service = "systemd",
    slice = "systemd",
    tpp = "cpp",
    xtce = "xml",
    xteds = "xml",
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
