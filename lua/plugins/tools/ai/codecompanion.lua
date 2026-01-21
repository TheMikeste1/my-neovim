---@module "codecompanion"
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "stevearc/dressing.nvim", opts = {} },
  },
  config = function()
    require("codecompanion").setup({
      interactions = {
        chat = {
          adapter = "sdl_openai",
          -- adapter = "local_ollama",
        },
        inline = {
          adapter = "sdl_openai",
          -- adapter = "local_ollama",
        },
        agent = {
          adapter = "sdl_openai",
          -- adapter = "local_ollama",
        },
        cmd = {
          adapter = "sdl_openai",
          -- adapter = "local_ollama",
        },
      },
      adapters = {
        http = {
          local_ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = "http://localhost:11434",
              },
              schema = {
                model = {
                  default = "gpt-oss:20b",
                },
              },
            })
          end,
          sdl_openai = function()
            -- See <https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/adapters/http/openai.lua> for settings
            
          end,
        },
      },
    })

    -- Keymaps
    vim.keymap.set({ "n", "v" }, "<C-g>cc", "<cmd>CodeCompanionChat Toggle<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>ca", "<cmd>CodeCompanionChat Add<cr>")
    vim.keymap.set({ "n", "v" }, "<C-g>cp", "<cmd>CodeCompanion<cr>")
  end,
}
