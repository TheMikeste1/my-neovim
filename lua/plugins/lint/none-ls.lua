local FILE_NONTYPES = {
  "alpha",
  "notify",
  "noice",
  "fugitive",
  "TelescopePrompt",
  "OverseerForm",
  "OverseerList",
  "neo-tree",
  "lazy",
}

local BUFFER_NONTYPES = {
  "terminal",
}

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
return {
  "nvimtools/none-ls.nvim",
  config = function()
    -- We'll use conform for formatting and null_ls for other stuff
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.refactoring,

        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.dotenv_linter,
        -- null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.trail_space,

        -- Ansible
        null_ls.builtins.diagnostics.ansiblelint,

        -- C++
        null_ls.builtins.diagnostics.cppcheck.with({
          args = {
            "--enable=warning,performance,portability,information",
            "--template=gcc",
            "--disable=missingInclude",
            "--suppress=unknownMacro",
            "--suppress=checkersReport",
            "--suppress=normalCheckLevelMaxBranches",
            "--suppress=unmatchedSuppression",
            "--language=c++",
            "--inline-suppr",
            "--force",
            "--library=googletest",
            "-j",
            "8",
            "--cppcheck-build-dir=./.cache/cppcheck",
            -- "--project=./build/compile_commands.json",
            "$FILENAME",
          },
        }),

        -- CMake
        null_ls.builtins.diagnostics.cmake_lint,

        -- CSS
        null_ls.builtins.diagnostics.stylelint,

        -- Docker
        null_ls.builtins.diagnostics.hadolint,

        -- Fish
        null_ls.builtins.diagnostics.fish,

        -- Godot
        null_ls.builtins.diagnostics.gdlint,

        -- HTML/XML
        null_ls.builtins.diagnostics.tidy,

        -- Make
        null_ls.builtins.diagnostics.checkmake,

        -- Markdown
        null_ls.builtins.diagnostics.markdownlint.with({
          extra_args = {"--disable", "MD013", "MD041", "--config", vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "markdownlint.json")}
        }),
        null_ls.builtins.hover.dictionary,

        -- Python
        null_ls.builtins.diagnostics.pylint.with({
          extra_args = { "--disable=useless-option-value,unknown-option-value,unrecognized-option" },
          prefer_local = ".venv/bin",
        }),
        null_ls.builtins.diagnostics.pydoclint,

        -- Shell/Bash
        null_ls.builtins.hover.printenv,
        null_ls.builtins.diagnostics.zsh,

        -- SQL
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" }, -- change to your dialect
        }),

        -- Web

        -- YAML
        null_ls.builtins.diagnostics.yamllint.with({
          extra_args = {"--config-data", "{extends: default, rules: {line-length: {max: 240}}}"}
        }),
      },
      should_attach = function(bufnr)
        local filetype = vim.fn.getbufvar(bufnr, "&filetype")
        if filetype ~= nil then
          for _, nontype in ipairs(FILE_NONTYPES) do
            if filetype == nontype then
              return false
            end
          end
        end

        local bufferType = vim.fn.getbufvar(bufnr, "&buftype")
        if bufferType ~= nil then
          for _, nontype in ipairs(BUFFER_NONTYPES) do
            if bufferType == nontype then
              return false
            end
          end
        end

        return true
      end,
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
}
