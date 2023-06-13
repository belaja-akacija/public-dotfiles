------------------------------------------------------------

-- AESTHETICS

------------------------------------------------------------

vim.cmd[[set termguicolors

" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

let &t_EI = "\<esc>[ q"
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"

highlight LineNr guifg=#9e9e9e
highlight Sneak guifg=#444444 guibg=#5fd7d7
]]

--vim.cmd[[colorscheme lucius]]
--vim.cmd[[LuciusBlackHighContrast]]
