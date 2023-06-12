--[[
Basic Settings
]]--

--require ('necessities')
-- to go to the 'required' files, use <Leader>] on the file name
require ('plugins')
require ('functions')
require ('aesthetics')

local set = vim.opt
local keymap = vim.api.nvim_set_keymap
set.wrap = true
set.exrc = true
set.secure = true
set.linebreak = true
set.mouse = a
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 2
set.ignorecase = true
set.infercase = true
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.hlsearch = true
set.tags='./tags,tags,./doc/tags'
set.numberwidth=1
vim.cmd[[set cpoptions+=n]]
set.nu=true
set.timeoutlen=300
set.ttimeoutlen=0
vim.cmd[[set nrformats=]]

--[[
Mappings
]]--

keymap('n', 'Q', '<Nop>', { noremap = true, silent = true })
keymap('n', ';', ':', { noremap = true, silent = false })
keymap('n', ':', ';', { noremap = true, silent = false })
vim.g.mapleader = ' '
vim.g.maplocalleader = ',,'
keymap('n', '<C-e>', ':vsp ~/.config/nvim/init.lua <CR><C-w>R', { noremap = true, silent = true })
keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = false })
keymap('n', '<C-s>', ':%s/\\v()<LEFT>', { noremap = true, silent = false })
keymap('n', '<Leader>e', ':exe "norm "<LEFT>', { noremap = true, silent = false })
keymap('n', '<Leader>vt', ':vnew term://zsh<CR>a', { noremap = true, silent = true })
keymap('n', '<Leader>ht', ':new term://zsh<CR>a', { noremap = true, silent = true })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
keymap('n', '<Leader>vs', ':vsp<CR>', { noremap = true, silent = false })
keymap('n', '<Leader>hs', ':sp<CR>', { noremap = true, silent = false })
keymap('n', '<C-j>', '<C-w>5-', { noremap = false, silent = true })
keymap('n', '<C-k>', '<C-w>5+', { noremap = false, silent = true })
keymap('n', '<C-h>', '<C-w>5<', { noremap = false, silent = true })
keymap('n', '<C-l>', '<C-w>5>', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>l', '<C-w>l', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>h', '<C-w>h', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>k', '<C-w>k', { noremap = false, silent = true })
keymap('n', '<Leader><Leader>j', '<C-w>j', { noremap = false, silent = true })
keymap('n', '<Leader>cw', '<C-w>c', { noremap = false, silent = false })
keymap('n', '<Leader>sw', '<C-w>R', { noremap = false, silent = false })
keymap('', '<Leader>m', '<C-w>_<C-w><Bar>', { noremap = false, silent = true })
keymap('', '<Leader>t', '<C-w>=', { noremap = false, silent = true })
keymap('', '<Leader>vw', '<C-w>t<C-w>H', { noremap = false, silent = true })
keymap('', '<Leader>hw', '<C-w>t<C-w>K', { noremap = false, silent = true })
keymap('n', '<Leader>b', ':buffer<Space>', { noremap = true, silent = false })
keymap('n', '<Leader>j', ':bnext<CR>', { noremap = true, silent = false })
keymap('n', '<Leader>k', ':bprev<CR>', { noremap = true, silent = false })
keymap('', '<Leader>]', '<C-]>', { noremap = true, silent = true })
keymap('', '<Leader>[', '<C-t>', { noremap = true, silent = true })
keymap('i', '<S-Tab>', '<C-n>', { noremap = false, silent = true })
keymap('n', '<Leader>o', '<C-o>', { noremap = true, silent = true })
keymap('n', '<Leader>i', '<C-i>', { noremap = true, silent = true })
keymap('', ':', '<Plug>SneakNext', { noremap = false, silent = false })
keymap('', ':', '<Plug>VSneakNext', { noremap = false, silent = false })
keymap('', ':', '<Plug>SneakNext', { noremap = false, silent = false })
keymap('n', '<Leader>s', ':let @/ = ""<CR>', { noremap = true, silent = true })
keymap('n', '<C-n>', ':set relativenumber!<CR>', { noremap = true, silent = true })
keymap('', '<UP>', ':windo diffthis<CR>', { noremap = true, silent = false })
keymap('', '<DOWN>', ':diffoff<CR>', { noremap = true, silent = false })
keymap('', '<LEFT>', '<Nop>', { noremap = true, silent = false })
keymap('', '<RIGHT>', '<Nop>', { noremap = true, silent = false })
keymap('v', '//', '<Plug>NERDCommenterToggle<CR>', { noremap = false, silent = true })
keymap('n', '//', '<Plug>NERDCommenterToggle<CR>', { noremap = false, silent = true })
keymap('n', '<Leader>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
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
keymap('n', '<Leader>rv', ':so ~/.config/nvim/init.lua <CR>', { noremap = true, silent = false })
keymap('n', '<Leader>g', ':vsp<CR>:GuileTerminal<CR>a', { noremap = true, silent = true })
keymap('n', '<Leader>gl', ':vsp<CR>:GuileLyTerminal<CR>a', { noremap = true, silent = true })
keymap('n', '<F10>', ':exe "normal cl\\<C-v>u2713"<ESC>', { noremap = true, silent = true })
keymap('x', '<C-c>', '"+y', { noremap = false, silent = false })

-- telescope shit
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- MUST BE IN FILE OTHERWISE WON'T WORK
vim.cmd[[let g:rainbow_active = 0
let g:slime_target = "neovim"]]

vim.cmd[[
let g:goyo_width=100
]]
