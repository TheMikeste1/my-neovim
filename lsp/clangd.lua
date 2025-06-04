return {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--import-insertions",
    "--malloc-trim",
  },
}
