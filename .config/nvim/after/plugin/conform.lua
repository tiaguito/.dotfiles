local conform = require "conform"
conform.setup {
  formatters_by_ft = {
    -- go stuff
    go = { "gofumpt", "goimports_reviser", "golines" },
    -- python stuff
    python = { "black" },
    -- web dev stuff
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd", "djlint" },
    markdown = { "prettierd" },
    -- C/C++ stuff
    -- c = { "clang-format" },
    -- cpp = { "clang-format" },
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
}
