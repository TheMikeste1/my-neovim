return {
  "milanglacier/minuet-ai.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 512,
    provider_options = {
      openai_fim_compatible = {
        -- For Windows users, TERM may not be present in environment variables.
        -- Consider using APPDATA instead.
        api_key = "TERM",
        name = "Ollama",
        end_point = "http://localhost:11434/v1/completions",
        model = "qwen2.5-coder:7b",
        optional = {
          max_tokens = 56,
          top_p = 0.9,
        },
      },
    },
    virtualtext = {
      auto_trigger_ft = { "*" },
      auto_trigger_ignore_ft = {
        "OverseerForm",
        "OverseerList",
        "OverseerOutput",
        "TelescopePrompt",
        "noice",
        "snacks_input",
        "snacks_picker_input",
      },
      show_on_completion_menu = false,
      keymap = {
        accept = "<C-g><CR>",
        accept_line = nil,
        accept_n_lines = nil,
        next = "<C-g>n",
        prev = "<C-g>p",
        dismiss = nil,
      },
    },
  },
}
