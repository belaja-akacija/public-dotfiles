--[[
 _          _        _             _              _  _       _
| |__   ___| | __ _ (_) __ _  __ _| | ____ _  ___(_)(_) __ _( )___
| '_ \ / _ \ |/ _` || |/ _` |/ _` | |/ / _` |/ __| || |/ _` |// __|
| |_) |  __/ | (_| || | (_| | (_| |   < (_| | (__| || | (_| | \__ \
|_.__/ \___|_|\__,_|/ |\__,_|\__,_|_|\_\__,_|\___|_|/ |\__,_| |___/
                  |__/                            |__/
                   _       _ _     _
                  (_)_ __ (_) |_  | |_   _  __ _
                  | | '_ \| | __| | | | | |/ _` |
                  | | | | | | |_ _| | |_| | (_| |
                  |_|_| |_|_|\__(_)_|\__,_|\__,_|
--]]

------------------------------------------------------------
-- TODO:
-- figure out why mappings in a separate file doesn't work
-- refactor 'refresh vim rc" to include all of the lua files. write a function for this.

------------------------------------------------------------

--[[
to go to the 'required' files, use <Leader>] on the file name
--]]
require ('options')
require ('plugins')
require ('after')
require ('functions')
require ('aesthetics')

local keymap = vim.api.nvim_set_keymap

------------------------------------------------------------

-- MAPPINGS

------------------------------------------------------------

------------------------------------------------------------

-- Leader settings

------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ',,'

------------------------------------------------------------

-- Nop Q

------------------------------------------------------------
keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })

------------------------------------------------------------

-- Remap ; to :

------------------------------------------------------------
keymap('n', ';', ':', { noremap = true, silent = false })
keymap('n', ':', ';', { noremap = true, silent = false })

------------------------------------------------------------

-- Save file

------------------------------------------------------------
keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = false })

------------------------------------------------------------

-- Vim configuration

------------------------------------------------------------
keymap('n', '<C-e>', ':e ~/.config/nvim/init.lua <CR>', { noremap = true, silent = true })
keymap('n', '<Leader>rv', ':so ~/.config/nvim/init.lua <CR>', { noremap = true, silent = false })

------------------------------------------------------------

-- Splits

------------------------------------------------------------
-- create splits
keymap('n', '<Leader>vs', ':vsp<CR>', { noremap = true, silent = false })
keymap('n', '<Leader>hs', ':sp<CR>', { noremap = true, silent = false })
-- create terminal splits
-- locally, turn off line numbers for the splits
keymap('n', '<Leader>vt', ':vnew term://zsh<CR>:setlocal number!<CR>a', { noremap = true, silent = true })
keymap('n', '<Leader>ht', ':new term://zsh<CR>:setlocal number!<CR>a', { noremap = true, silent = true })
-- create guile scheme terminal splits
keymap('n', '<Leader>g', ':vsp<CR>:GuileTerminal<CR>:setlocal number!<CR>a', { noremap = true, silent = true })
keymap('n', '<Leader>gl', ':vsp<CR>:GuileLyTerminal<CR>:setlocal number!<CR>a', { noremap = true, silent = true }) -- TODO enable this only in lilypond files
-- Escape out of terminal
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- resizing splits
keymap('n', '<C-j>', '<C-w>5-', { noremap = false, silent = true })
keymap('n', '<C-k>', '<C-w>5+', { noremap = false, silent = true })
keymap('n', '<C-h>', '<C-w>5<', { noremap = false, silent = true })
keymap('n', '<C-l>', '<C-w>5>', { noremap = false, silent = true })
-- move between splits
keymap('n', '<Leader><Leader>l', '<C-w>l', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>h', '<C-w>h', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>k', '<C-w>k', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>j', '<C-w>j', { noremap = false, silent = true })
-- close/swap splits
keymap('n', '<Leader>cw', '<C-w>c', { noremap = false, silent = false })
keymap('n', '<Leader>sw', '<C-w>R', { noremap = false, silent = false })
-- swap between horiz/vert layout
keymap('', '<Leader>vw', '<C-w>t<C-w>H', { noremap = false, silent = true })
keymap('', '<Leader>hw', '<C-w>t<C-w>K', { noremap = false, silent = true })
-- maximize/equalize splits
keymap('', '<Leader>m', '<C-w>_<C-w><Bar>', { noremap = false, silent = true })
keymap('', '<Leader>t', '<C-w>=', { noremap = false, silent = true })

------------------------------------------------------------

-- Arrow key functions

------------------------------------------------------------
-- diff mode
keymap('', '<UP>', ':windo diffthis<CR>', { noremap = true, silent = false })
keymap('', '<DOWN>', ':diffoff<CR>', { noremap = true, silent = false })
keymap('', '<LEFT>', '<Nop>', { noremap = true, silent = false })
keymap('', '<RIGHT>', '<Nop>', { noremap = true, silent = false })

------------------------------------------------------------

-- Cursor position jumps

------------------------------------------------------------
keymap('n', '<Leader>o', '<C-o>', { noremap = true, silent = true })
keymap('n', '<Leader>i', '<C-i>', { noremap = true, silent = true })

------------------------------------------------------------

-- Jump back and forth tags

------------------------------------------------------------
keymap('', '<Leader>]', '<C-]>', { noremap = true, silent = true })
keymap('', '<Leader>[', '<C-t>', { noremap = true, silent = true })

------------------------------------------------------------

-- Buffers

------------------------------------------------------------
keymap('n', '<Leader>j', ':bnext<CR>', { noremap = true, silent = false })
keymap('n', '<Leader>k', ':bprev<CR>', { noremap = true, silent = false })

------------------------------------------------------------

-- Toggles

------------------------------------------------------------
--keymap('n', '<C-n>', ':set relativenumber!<CR>', { noremap = true, silent = true })

------------------------------------------------------------

-- Misc useful bindings

------------------------------------------------------------
-- search and replace
keymap('n', '<C-s>', ':%s/\\v()<LEFT>', { noremap = true, silent = false })
-- execute a norm command
keymap('n', '<Leader>e', ':exe "norm "<LEFT>', { noremap = true, silent = false })
-- replace with check mark under cursor
keymap('n', '<F10>', ':exe "normal cl\\<C-v>u2713"<ESC>', { noremap = true, silent = true })
-- remove search highlighting
keymap('n', '<Leader>s', ':let @/ = ""<CR>', { noremap = true, silent = true })
-- copy to system clipboard in visual mode
keymap('x', '<C-c>', '"+y', { noremap = false, silent = false })

------------------------------------------------------------

-- Plugin specific bindings

------------------------------------------------------------
-- sneak
keymap('', ':', '<Plug>SneakNext', { noremap = false, silent = false })
keymap('', ':', '<Plug>VSneakNext', { noremap = false, silent = false })
keymap('', ':', '<Plug>SneakNext', { noremap = false, silent = false })
-- nerdcommenter
keymap('v', '//', '<Plug>NERDCommenterToggle<CR>', { noremap = false, silent = true })
keymap('n', '//', '<Plug>NERDCommenterToggle<CR>', { noremap = false, silent = true })
-- surround.vim
keymap('n', 'dl', '<Plug>Dsurround', { noremap = false, silent = false })
keymap('n', 'cs', '<Plug>Csurround', { noremap = false, silent = false })
keymap('n', 'cL', '<Plug>CSurround', { noremap = false, silent = false })
keymap('n', 'yl', '<Plug>Ysurround', { noremap = false, silent = false })
keymap('n', 'yL', '<Plug>YSurround', { noremap = false, silent = false })
keymap('n', 'yll', '<Plug>Yssurround', { noremap = false, silent = false })
keymap('n', 'yLl', '<Plug>YSsurround', { noremap = false, silent = false })
keymap('n', 'yLL', '<Plug>YSSurround', { noremap = false, silent = false })
keymap('x', 'L', '<Plug>VSurround', { noremap = false, silent = false })
keymap('x', 'gL', '<Plug>VgSurround', { noremap = false, silent = false })

-- Menu for spell check
vim.cmd[[
anoremenu SpellLang.off :setlocal nospell<CR>
anoremenu SpellLang.EN :setlocal spell spelllang=en<CR>
]]
keymap('', '<F11>', ':popup SpellLang<CR>', {noremap = true})

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
