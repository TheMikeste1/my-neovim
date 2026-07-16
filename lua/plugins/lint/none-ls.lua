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
    local helpers = require("null-ls.helpers")
    local vsg_lint = {
      name = "VSG",
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "vhdl" },
      generator = helpers.generator_factory({
        command = "vsg",
        args = function(params)
          local rv = {}
          table.insert(rv, "-c=" .. vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "vsg.json"))
          table.insert(rv, "--stdin")
          table.insert(rv, "-of=syntastic")
          return rv
        end,
        cwd = nil,
        check_exit_code = { 0, 1 },
        from_stderr = false,
        ignore_stderr = true,
        to_stdin = true,
        format = "line",
        multiple_files = false,
        on_output = helpers.diagnostics.from_patterns({
          {
            pattern = [[(%w+).*%((%d+)%)(.*)%s+%-%-%s+(.*)]],
            groups = { "severity", "row", "code", "message" },
            overrides = {
              severities = {
                -- 2 is for warnings, nvim showing as an error can be obnoxious. Change if desired
                ["ERROR"] = 2,
                ["WARNING"] = 3,
                ["INFORMATION"] = 3,
                ["HINT"] = 4,
              },
            },
          },
        }),
      }),
    }

    local gersemi_diagnostics = helpers.make_builtin({
      name = "gersemi",
      meta = {
        description = "A clean, modern CMake formatter used as a linter via its --check flag.",
      },
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "cmake" },
      generator = helpers.generator_factory({
        command = "gersemi",
        args = { "--check", "-" }, -- "-" tells gersemi to read from standard input
        to_stdin = true,
        from_stderr = true, -- gersemi routes syntax/formatting errors to stderr
        format = "line", -- Process gersemi output line-by-line

        -- Parse gersemi's standard error format: <stdin>:line:col: message
        check_exit_code = function(code)
          return code <= 1 -- Prevent none-ls from crashing on lint errors
        end,
        on_output = helpers.diagnostics.from_pattern(
          "([^:]+):(%d+):(%d+):%s*(.*)",
          { "filename", "row", "col", "message" }
        ),
      }),
    })

    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.refactoring,

        null_ls.builtins.completion.spell,

        -- null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.gitleaks,
        null_ls.builtins.diagnostics.trail_space,

        -- # Language-specific
        -- Ansible
        null_ls.builtins.diagnostics.ansiblelint,

        -- C++
        null_ls.builtins.diagnostics.cppcheck.with({
          extra_args = {
            "--enable=warning,performance,portability,information",
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
          },
        }),

        -- CMake
        gersemi_diagnostics,
        -- null_ls.builtins.diagnostics.cmake_lint.with({
        --   args = {
        --     "-c",
        --     vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "cmakelint.py"),
        --   },
        -- }),

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

        -- Kotlin
        null_ls.builtins.diagnostics.ktlint,

        -- Make
        null_ls.builtins.diagnostics.checkmake,

        -- Markdown
        null_ls.builtins.diagnostics.markdownlint.with({
          extra_args = {
            "--disable",
            "MD013",
            "MD041",
            "MD047",
            "--config",
            vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "markdownlint.json"),
          },
        }),
        null_ls.builtins.hover.dictionary,

        -- Python
        null_ls.builtins.diagnostics.pylint.with({
          extra_args = { "--disable=useless-option-value,unknown-option-value,unrecognized-option" },
          prefer_local = ".venv/bin",
        }),
        null_ls.builtins.diagnostics.pydoclint,

        -- Ruby
        null_ls.builtins.diagnostics.rubocop,

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
          extra_args = { "--config-data", "{extends: default, rules: {line-length: {max: 240}}}" },
        }),

        vsg_lint,
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
      temp_dir = "/tmp",
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
}
