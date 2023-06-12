--[[
*plugins*
]]--
return require('packer').startup(function(use)
  use 'vim-airline/vim-airline'
  use 'wbthomason/packer.nvim'
  use 'Galicarnax/vim-regex-syntax'
  use 'ap/vim-css-color'
  --use 'danilamihailov/vim-tips-wiki'
  --use 'dhruvasagar/vim-table-mode'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'justinmk/vim-sneak'
  use 'markonm/traces.vim'
  --use 'preservim/nerdtree'
  use 'psliwka/vim-smoothie'
  use 'scrooloose/nerdcommenter'
  ----use('styled-components/vim-styled-components', {branch = 'main'})
  --use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'HiPhish/guile.vim'
  use 'luochen1990/rainbow'
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'jpalardy/vim-slime'
  use ({
    'vlime/vlime',
    rtp = 'vim/'
  })
-- autocomplete 
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/nvim-cmp'},
  }
}
-- telescope
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}
end)
