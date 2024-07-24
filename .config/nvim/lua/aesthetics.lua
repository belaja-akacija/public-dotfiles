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

-- GruvBox options
vim.g['gruvbox_italic'] = 1;
--vim.g['gruvbox_improved_strings'] = 1;
--vim.g['gruvbox_inverse'] = 1;
vim.g['gruvbox_improved_warnings'] = 1;
vim.g['gruvbox_contrast_light'] = 'hard';

-- Set airline theme
--vim.cmd[[let g:airline_theme='base16_chalk']]

-- Change background colors depending on time of day.
local hr = tonumber(os.date('%H', os.time()))
if hr > 8 and hr < 17 then
  vim.cmd.colorscheme('gruvbox-material');
  vim.opt.background = 'light'
    vim.g['airline_theme'] = 'qwq';
else
  vim.cmd.colorscheme('gruvbox-material');
  vim.opt.background = 'dark'
  vim.g['airline_theme'] = 'base16_chalk';
end

--vim.cmd[[colorscheme lucius]]
--vim.cmd[[LuciusBlackHighContrast]]
