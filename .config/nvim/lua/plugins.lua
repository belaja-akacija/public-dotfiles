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
  use 'zyedidia/literate.vim'
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
-- harpoon, to quickly move between files
use {'ThePrimeagen/harpoon'}
-- gruvbox colorscheme
use {'morhetz/gruvbox'}
use {'sainnhe/gruvbox-material'}
use {'rafi/awesome-vim-colorschemes'}
--use {'lmburns/kimbox'}

-- conjure (conversational software development)
--use {'Olical/conjure'}
--use {'Olical/aniseed'}
end)
