------------------------------------------------------------

-- FUNCTIONS

------------------------------------------------------------

------------------------------------------------------------

-- Trime whitespace on save

------------------------------------------------------------

vim.cmd[[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
]]

vim.api.nvim_create_autocmd({'BufWrite'}, {
  pattern = {"*"},
  command = ":call TrimWhitespace()"
})

------------------------------------------------------------

-- Compile plugins.lua file on update

------------------------------------------------------------

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

local function lilyRender ()
  local handle = io.popen("exec ~/Documents/scripts/shell/not-running.sh")
  local result = handle:read("*line")
  handle:close()
  vim.cmd([[
  :!lilypond -dno-point-and-click -dembed-source-code %
  ]])
  if result == "running" then
    print ('running')
  else
    os.execute(string.format("zathura %s.pdf &", vim.fn.expand("%:r")))
  end
end


------------------------------------------------------------

-- Render a lilypond file and open it

------------------------------------------------------------

local lyBindings = vim.api.nvim_create_augroup("lybindings", {clear = true})
vim.api.nvim_create_autocmd(
{"Filetype"},
{pattern = "lilypond",
callback = function()
  vim.keymap.set('n', '<Leader>ll', function() lilyRender() end, {buffer = true})
end,
group = lyBindings}
)


------------------------------------------------------------

-- Toggle bools in file

------------------------------------------------------------

-- TODO figure out how to make file (language) specific

local function toggleBool()
 local under_cursor = vim.fn.expand("<cword>");
 local toggle = "";
 if (under_cursor == "true") then
   toggle = "false";
   vim.cmd("normal! diwi" .. toggle);
 elseif (under_cursor == "false") then
   toggle = "true";
   vim.cmd("normal! diwi" .. toggle);
   -- for lisp style
 elseif (under_cursor == "t") then
   toggle = "nil"
   vim.cmd("normal! diwi" .. toggle);
 elseif (under_cursor == "nil") then
   toggle = "t"
   vim.cmd("normal! diwi" .. toggle);
 else
   print("nothing")
 end
end

vim.keymap.set('n', '<F9>', function ()
 toggleBool()
end,
{buffer = true})


------------------------------------------------------------

-- Toggle on Rainbow parens on scm files

------------------------------------------------------------

vim.api.nvim_create_autocmd({'BufRead','BufNewFile'},
{pattern = {"*.scm"},
command = [[set ft=scheme.guile]]})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
{pattern = {"*.scm"},
command = [[RainbowToggleOn]],
})

------------------------------------------------------------

-- Go to last cursor position in file on open

------------------------------------------------------------

vim.api.nvim_create_autocmd(
"BufReadPost",
{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })


------------------------------------------------------------

-- Highlight on yank

------------------------------------------------------------

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

------------------------------------------------------------

-- Don't auto comment a new line

------------------------------------------------------------

vim.api.nvim_create_autocmd("BufEnter", {command = [[set formatoptions-=cro]]})

vim.cmd[[
command GuileTerminal terminal guile
command GuileLyTerminal terminal lilypond scheme-sandbox
]]

------------------------------------------------------------

-- Setup lsp-zero

------------------------------------------------------------

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- ghost text for lsp
require('cmp').setup({
  experimental = {ghost_text = true,},
})

