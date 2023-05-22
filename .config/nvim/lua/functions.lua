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

function lilyRender ()
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
  vim.keymap.set('n', '<Leader>ll', function() lilyRender() end, {buffer = true})
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
