vim.notify("START HARPER_LS")
return {
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
        ToDoHyphen = false,
        RepeatedWords = false,
      },
      isolateEnglish = false,
    },
  },
}
