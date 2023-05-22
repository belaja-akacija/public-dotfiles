--[[
*aesthetics*
]]--

vim.cmd[[colorscheme lucius]]
vim.cmd[[LuciusBlackHighContrast]]
vim.cmd[[set termguicolors

" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

let &t_EI = "\<esc>[ q"
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"

highlight LineNr guifg=#9e9e9e
highlight Sneak guifg=#444444 guibg=#5fd7d7
]]

local function status_line()
  local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  --local mode = "%v:lua.vim.fn.mode()%"
  local file_name = "%-.16t"
  local buf_nr = "[%n]"
  local modified = " %-m"
  local file_type = " %y"
  local right_align = "%="
  local line_no = "%10([%l,%v/%L%)]"
  local pct_thru_file = "%5p%%"

  return string.format(
  "%s%s%s%s%s%s%s%s",
  mode,
  file_name,
  buf_nr,
  modified,
  file_type,
  right_align,
  line_no,
  pct_thru_file
  )
end

vim.opt.statusline = status_line()
