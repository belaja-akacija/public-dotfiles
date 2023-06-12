--[[
*functions*
]]--
-- Compile plugins.lua file on update
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

function LilyRender ()
local handle = io.popen("exec ~/Documents/scripts/shell/not-running.sh")
local result = handle:read("*line")
handle:close()

--os.execute(string.format("lilypond -dno-point-and-click -dembed-source-code %s", vim.fn.expand("%")))
vim.cmd([[
:!lilypond -dno-point-and-click -dembed-source-code %
]])

if result == "running" then
 print ('running') 
 else 
   os.execute(string.format("zathura %s.pdf &", vim.fn.expand("%:r")))
end
end


-- Render a lilypond file and open it 
local lyBindings = vim.api.nvim_create_augroup("lybindings", {clear = true})
vim.api.nvim_create_autocmd(
{"Filetype"},
{pattern = "lilypond",
--command = [[nnoremap <buffer> <Leader>ll :!lilypond -dno-point-and-click -dembed-source-code % && zathura %:r.pdf & <Enter>]], 
callback = function()
  vim.keymap.set('n', '<Leader>ll', function() LilyRender() end, {buffer = true})
end,
-- callback = vim.keymap.set('n', '<buffer> <Leader>ll',lilyRender()),
group = lyBindings}
)



-- Toggle on Rainbow parens on scm files

vim.api.nvim_create_autocmd({'BufRead','BufNewFile'},
{pattern = {"*.scm"},
command = [[set ft=scheme.guile]]})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
{pattern = {"*.scm"},
command = [[RainbowToggleOn]],
})

-- Go to last cursor position in file on open
vim.api.nvim_create_autocmd(
"BufReadPost",
{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })


-- Highlight on yank

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- don't auto comment a new line
vim.api.nvim_create_autocmd("BufEnter", {command = [[set formatoptions-=cro]]})

vim.cmd[[
command GuileTerminal terminal guile
command GuileLyTerminal terminal lilypond scheme-sandbox
]]

-- setup lsp-zero
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

vim.lsp.set_log_level("debug")
require('lspconfig.configs').alive_lsp = {
  default_config = {
    name = 'alive_lsp',
    --cmd = {"sbcl", "--eval '(require \"asdf\")' --eval '(asdf:load-system \"alive-lsp\")' --eval '(alive/server:start)'"},
    cmd = {'/bin/sh', '/home/belajaakacija/Documents/scripts/alive-lsp.sh'},
    filetypes = {'lisp'},
    root_dir = require('lspconfig.util').root_pattern({'init.txt'})
  }
}

require('lspconfig').alive_lsp.setup({})

-- setup nvim-cmp-vlime
--require('cmp').setup.filetype({'lisp'}, {
    --sources = {
        --{name = 'vlime'}
    --}
--})

require('cmp').setup({
  experimental = {ghost_text = true,},
})


