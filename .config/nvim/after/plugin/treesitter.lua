local parsers = {
  "bash",
  "go",
  "javascript",
  "typescript",
  "html",
  "css",
  "java",
  "json",
  "c",
  "cpp",
  "cmake",
  "lua",
  "vim",
  "vimdoc",
  "dockerfile",
  "query",
  "gitignore",
  "markdown",
  "yaml",
  "templ",
}

require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = parsers,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    -- vim.wo.folderexpr = 'v:lua.vim.treesitter.folderexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- indentation, provided by nvim-treesiter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
