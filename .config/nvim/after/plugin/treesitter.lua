local parsers = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "gitignore",
  "go",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "proto",
  "query",
  "templ",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldlevel = 99
    -- indentation, provided by nvim-treesiter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
