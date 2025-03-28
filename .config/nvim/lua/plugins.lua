------------------------------------------------------------

-- PLUGINS

------------------------------------------------------------

return require('packer').startup(function(use)
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
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
  use 'psliwka/vim-smoothie'
  use 'scrooloose/nerdcommenter'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'HiPhish/guile.vim'
  --use 'luochen1990/rainbow'
  use 'guns/vim-sexp'
  use 'jpalardy/vim-slime'
  -- literate programming in vim
  --use 'zyedidia/literate.vim'



  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use ({
    'vlime/vlime',
    rtp = 'vim/'
  })

  -- LSP --

  --use 'simrat39/rust-tools.nvim';
  use 'mrcjkb/rustaceanvim';
  use 'mfussenegger/nvim-dap';
  use 'neovim/nvim-lspconfig';
  use 'williamboman/mason.nvim';
  use 'williamboman/mason-lspconfig.nvim';
  --use 'puremourning/vimspector';

  -- Completion framework:
  use 'hrsh7th/nvim-cmp'

  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'

  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-lua/plenary.nvim'
  -- harpoon, to quickly move between files
  use {'ThePrimeagen/harpoon'}
  -- gruvbox colorscheme
  use {'morhetz/gruvbox'}
  use {'sainnhe/gruvbox-material'}
  use {'rafi/awesome-vim-colorschemes'}

  -- firenvim (nvim in browser)
  --use {
  --'glacambre/firenvim',
  --run = function() vim.fn['firenvim#install'](0) end
  --}
  --use {'lmburns/kimbox'}

  -- conjure (conversational software development)
  --use {'Olical/conjure'}
  --use {'Olical/aniseed'}

use "folke/todo-comments.nvim";
end)

