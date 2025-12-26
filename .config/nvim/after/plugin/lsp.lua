local nvim_lsp = vim.lsp.config

-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function OrganizeImports(timeoutms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- List all the references
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- Move to the next and previous diagnostics respectively
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    require('lspconfig').util.nvim_multiline_command [[
        :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]]
  end

  vim.cmd([[
            augroup formatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            autocmd BufWritePre <buffer> lua OrganizeImports(3000)
            augroup END
            ]])
end

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
  'pyright',
  'gopls',
  'eslint',
  'rust_analyzer',
  'clangd',
  'cmake',
  'lua_ls',
  'html',
  'htmx',
  'templ',
  'bashls'
}

for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    nvim_lsp(lsp, {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      }
    })
  elseif lsp == "lua_ls" then
    nvim_lsp(lsp, {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  else
    nvim_lsp(lsp, {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  vim.lsp.enable(lsp)
end
