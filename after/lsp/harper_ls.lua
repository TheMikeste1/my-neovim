return {
  settings = {
    ["harper-ls"] = {
      linters = {
        -- <https://writewithharper.com/docs/rules>
        ExpandArgument = false,
        ExpandParameter = false,
        ExpandStandardInputAndOutput = false,
        RepeatedWords = false,
        SentenceCapitalization = false,
        SpellCheck = false,
        ToDoHyphen = false,
      },
      isolateEnglish = false,
    },
  },
}
