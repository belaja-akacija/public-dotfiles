local keymap = vim.api.nvim_set_keymap;

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua", "commonlisp"},
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
}

-- vlime window settings

vim.cmd[[
let g:vlime_window_settings = {
  \ "arglist": {
    \ "pos": "topleft",
    \ "size": 1,
    \ "vertical": v:false
  \ },
  \ "repl": {
    \ "pos": "aboveleft",
    \ "size": winheight(".") / 5
  \ },
  \ "sldb": {
    \ "pos": "aboveleft",
    \ "size": 5
\ }
\ }
]]

-- Harpoon settings

keymap('n', '<C-t>', ':lua require("harpoon.ui").nav_next()<CR>', {noremap = true, silent = true});
keymap('n', '<C-n>', ':lua require("harpoon.ui").nav_prev()<CR>', {noremap = true, silent = true});
keymap('n', '<C-c>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {noremap = true, silent = true});
keymap('n', '<C-g>', ':lua require("harpoon.mark").add_file()<CR>', {noremap = true, silent = true});

-- LSP settings

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

--require('lspconfig.configs').millet = {
  --default_config = {
    --name = 'millet',
    --cmd = {'millet'},
    --filetypes = {'sml'},
    --root_dir = require('lspconfig.util').root_pattern({'main.sml'})
  --}
--}

--require('lspconfig').millet.setup({})

--vim.cmd([[
     --let g:opamshare = substitute(system('opam var share'),'\n$','','''')
     --execute "set rtp+=" . g:opamshare . "/merlin/vim"]]);
