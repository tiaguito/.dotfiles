" Plugins will be downloaded under the specified directory.
call plug#begin("$VIMCONFIG/plugged")
" Declare the list of plugins.

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colorscheme
Plug 'folke/tokyonight.nvim'

" Undo Tree
Plug 'mbbill/undotree'

" Auto pairs
Plug 'windwp/nvim-autopairs'

" Git
Plug 'tpope/vim-fugitive'

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Debugger Adapter Protocol
Plug 'nvim-neotest/nvim-nio'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" Cloack
Plug 'laytan/cloak.nvim'

" Status line
Plug 'nvim-mini/mini.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
