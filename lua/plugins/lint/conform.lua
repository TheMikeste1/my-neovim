return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<A-F>",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      -- log_level = vim.log.levels.DEBUG,
      -- Conform will run multiple formatters sequentially
      -- Use a sub-list to run only the first available formatter
      formatters_by_ft = {
        -- Build tools
        cmake = { "cmake_format" },
        -- Programming
        c = { "uncrustify", "clang-format" },
        cpp = { "uncrustify", "clang-format" },
        cs = { "csharpier", lsp_format = "fallback" },
        cuda = { "clang-format" },
        gdscript = { "gdformat" },
        java = { "uncrustify", "clang-format" },
        proto = { "clang-format" },
        ruby = { "rubocop" },
        rust = { "rustfmt" },
        vhdl = { "vsg" },
        zig = { "zigfmt" },
        -- Scripting
        lua = { "stylua" },
        python = { "isort", "yapf" },
        -- Data
        sql = { "sqlfluff" },
        -- Shell
        fish = { "fish_indent" },
        sh = { "beautysh", "shellharden" },
        zsh = { "beautysh", "shellharden" },
        -- Web
        javascript = { "biome", "prettier" },
        typescript = { "biome", "prettier" },
        javascriptreact = { "biome", "prettier" },
        typescriptreact = { "biome", "prettier" },
        vue = { "biome", "prettier" },
        json = { "biome", "prettier" },
        jsonc = { "biome", "prettier" },
        scss = { "stylelint" },
        less = { "stylelint" },
        css = { "stylelint" },
        sass = { "stylelint" },
        xml = { "xmlformat" },
        xsd = { "xmlformat" },
        -- Config Files
        toml = { "taplo" },
        yaml = { "yamlfix" },
        -- Writing
        markdown = { "markdownlint" },
      },
      -- Set up format-on-save
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      -- Customize formatters
      formatters = {
        ["clang-format"] = {
          cwd = require("conform.util").root_file({ ".editorconfig", ".git", ".clang-format" }),
        },
        black = {
          prepend_args = { "--line-length", "160" },
        },
        beautysh = {
          prepend_args = { "--indent-size", "2" },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        uncrustify = {
          env = {
            UNCRUSTIFY_CONFIG = vim.fn.expand("~") .. "/.githooks/config/precommit/uncrustify.cfg",
          },
        },
        cmake_format = {
          prepend_args = {
            "-c",
            vim.fn.expand("~") .. "/.githooks/config/precommit/cmake-format.yaml",
          },
        },
        gdformat = {
          args = {
            "--use-spaces=2",
            "-",
          },
        },
        markdownlint = {
          prepend_args = {
            "--config",
            vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "markdownlint.json"),
          },
        },
        mdformat = {
          prepend_args = {
            "--number",
          },
        },
        xmlformat = {
          prepend_args = {
            "--preserve-attributes",
            "--selfclose",
            "--blanks",
            "--eof-newline",
          },
        },
        vsg = {
          prepend_args = {
            "-c",
            -- Rules: <https://vhdl-style-guide.readthedocs.io/en/stable/rules.html>
            vim.fs.joinpath(vim.fn.stdpath("config"), "tool_configs", "vsg.json"),
            "--fix",
          },
        },
      },
    })
  end,
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

    vim.api.nvim_create_user_command("ConformLog", function()
      local path = vim.fs.joinpath(vim.fn.stdpath("log"), "conform.log")

      local buf = vim.api.nvim_create_buf(false, true)
      local width = vim.o.columns - 3
      local height = vim.o.lines - 2
      local opts = {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width)),
        row = math.floor((vim.o.lines - height)),
        style = "minimal",
        border = "rounded",
      }

      local _ = vim.api.nvim_open_win(buf, true, opts)

      vim.cmd("edit " .. vim.fn.fnameescape(path))

      local current_buf = vim.api.nvim_get_current_buf()
      vim.bo[current_buf].readonly = true
      vim.bo[current_buf].modifiable = false
    end, {
      desc = "Open Conform's log file",
    })

    vim.api.nvim_create_user_command("ConformClearLog", function()
      local path = vim.fs.joinpath(vim.fn.stdpath("log"), "conform.log")
      local file = io.open(path, "w")

      if file then
        file:close()
        vim.notify("File cleared successfully.")
      else
        vim.notify(string.format("Error: Could not open %s.", path))
      end
    end, {
      desc = "Clear Conform's log file",
    })
  end,
}
