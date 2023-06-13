------------------------------------------------------------

-- AESTHETICS

------------------------------------------------------------

vim.cmd[[
set termguicolors
]]

-- better cursors
vim.cmd[[
let &t_EI = "\<esc>[ q"
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
]]

-- sets sneak and linenr colors
vim.cmd[[
highlight LineNr guifg=#9e9e9e
highlight Sneak guifg=#444444 guibg=#5fd7d7
]]

-- Set airline theme
vim.cmd[[let g:airline_theme=base16_chalk]]

--vim.cmd[[colorscheme lucius]]
--vim.cmd[[LuciusBlackHighContrast]]
