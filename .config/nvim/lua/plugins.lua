--[[
*plugins*
]]--
return require('packer').startup(function(use)
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
  use "lukas-reineke/indent-blankline.nvim"
  --use 'kovisoft/paredit'
end)
