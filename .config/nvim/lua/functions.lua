-----------------------------------------------------------

-- FUNCTIONS

------------------------------------------------------------

local vi = vim.api;

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

vi.nvim_create_autocmd({'BufWrite'}, {
  pattern = {"*"},
  command = ":call TrimWhitespace()"
})

------------------------------------------------------------

-- Format Rust file on save -- * depends on `rustfmt`

------------------------------------------------------------

--vi.nvim_create_autocmd({'BufWrite'}, {pattern = {"*.rs"},
--command = "silent! %!rustfmt"})


------------------------------------------------------------

-- Compile plugins.lua file on update

------------------------------------------------------------

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

------------------------------------------------------------

-- Render a lilypond file and open it

------------------------------------------------------------

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



local lyBindings = vi.nvim_create_augroup("lybindings", {clear = true})
vi.nvim_create_autocmd(
{"Filetype"},
{pattern = "lilypond",
callback = function()
  vim.keymap.set('n', '<Leader>ll', function() lilyRender() end, {buffer = true}) -- why does leader key work here, but I had to specify it for toggleBool?
end,
group = lyBindings}
)


------------------------------------------------------------

-- Toggle bools in file

------------------------------------------------------------

local languages = {
  -- add your own languages as needed
  lisp = {"t", "nil"},
  scheme = {"#t", "#f"},
  lilypond = {"t", "f"}, -- lilypond doesn't treat '#' as part of the word. Cursor needs to be on either 't' or 'f' to correctly change the element
  python = {"True", "False"},
  sql = {"TRUE", "FALSE"},
  vim = {"1", "0"},
  generic = {"true", "false"}
}

local function toggleBool()
  --[[ currently doesn't work with files that are not detected by filetype.vim for some reason.
   thankfully, 99% of the time this will work. --]]
  local file_type = vim.filetype.match({filename = vim.fn.expand("%")})
  local under_cursor = vim.fn.expand("<cword>");
  local toggle;
  local language;
  local replace_under_cursor = "normal! ciw";
  -- TODO add a little case if the word is only one letter, don't move the cursor
  local highlight_under_cursor = "normal! \"9yiwe"; -- yank into "9, so highlight.on_yank works
  print(file_type);

  if (languages[file_type] ~= nil) then
    language = languages[file_type]
  else
    language = languages["generic"];
  end

  if under_cursor == language[1] then
    toggle = 2;
  elseif under_cursor == language[2] then
    toggle = 1;
  else
    print('Nothing to toggle.');
  end

  if (toggle ~= nil) then
    vim.cmd(replace_under_cursor .. language[toggle]);
    vim.cmd(highlight_under_cursor);
  end
end

local toggleBools = vi.nvim_create_augroup("toggleBools", {clear = true})
vi.nvim_create_autocmd(
{"Filetype"},
{pattern = "*",
callback = function()
  vim.keymap.set('n', '<Leader>tp', function() toggleBool() end, {buffer = true}) end,
group = toggleBools})

------------------------------------------------------------

-- Toggle on Rainbow parens on scm files

------------------------------------------------------------

--vi.nvim_create_autocmd({'BufRead','BufNewFile'},
--{pattern = {"*.scm"},
--command = [[set ft=scheme.guile]]})

--vi.nvim_create_autocmd({'BufRead', 'BufNewFile'},
--{pattern = {"*.scm"},
--command = [[RainbowToggleOn]],
--})


------------------------------------------------------------

-- Go to end of a double paren form in lisp. e.g: (let ((var "value")))

------------------------------------------------------------

local lispForms = vi.nvim_create_augroup("lispForms", {clear = true});

vi.nvim_create_autocmd(
{"Filetype"},
{pattern = "lisp",
callback = function()
  vim.keymap.set('n', '<leader>ll', function() vim.cmd("normal! f);") end, {buffer = true}) end,
group = lispForms})

------------------------------------------------------------

-- Go to last cursor position in file on open

------------------------------------------------------------

vi.nvim_create_autocmd(
"BufReadPost",
{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })


------------------------------------------------------------

-- Highlight on yank

------------------------------------------------------------

local yankGrp = vi.nvim_create_augroup("YankHighlight", {clear = true})
vi.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

------------------------------------------------------------

-- Don't auto comment a new line

------------------------------------------------------------

vi.nvim_create_autocmd("BufEnter", {command = [[set formatoptions-=cro]]})

------------------------------------------------------------

-- Language specific layouts

------------------------------------------------------------

-- vi.nvim_create_autocmd("Filetype",
-- {pattern = "python",
-- command = [[
-- :vsp
-- :sp
-- ]]})

------------------------------------------------------------

-- Add header to shell script on new file

------------------------------------------------------------

vi.nvim_create_autocmd("BufNewFile",
{
  pattern = "*.sh",
  command = [[:exe "norm i#!/usr/bin/bash\<Esc>o\<CR>\<Esc>"]]
})

------------------------------------------------------------

-- WIP: CD into .../nvim/doc directory and back to the original directory when done looking at the files

------------------------------------------------------------

-- //put stuff here// --

------------------------------------------------------------

-- Setup lsp-zero

------------------------------------------------------------

--local lsp = require('lsp-zero').preset({})

--lsp.on_attach(function(client, bufnr)
  --lsp.default_keymaps({buffer = bufnr})
--end)

---- (Optional) Configure lua language server for neovim
--require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

--lsp.setup()

---- ghost text for lsp
--require('cmp').setup({
  --float_bordre = 'rounded',
  --call_servers = 'local',
  --configure_diagnostics = true,
  --setup_servers_on_start = true,
  --set_lsp_keymaps = {
    --preserve_mappings = false,
    --omit = {},
  --},
  --experimental = {ghost_text = true,},
  --manage_nvim_cmp = {
    --set_sources = 'recommended',
    ----set_basic_mapping = false,
    --set_extra_mappings = true,
    --set_format = true,
    --documentation_window = true,
  --},
--})

------------------------------------------------------------

-- guile terminal stuff. Where should this go?
--vim.cmd[[
--command GuileTerminal terminal guile
--command GuileLyTerminal terminal lilypond scheme-sandbox
--]]


------------------------------------------------------------

-- Better maximizing and minimizing

------------------------------------------------------------

_G.saved_window_state = {}

-- Save the sizes and cursor positions of all splits
local function save_window_state()
    _G.saved_window_state = {}
    for _, win_id in ipairs(vi.nvim_list_wins()) do
        local win_height = vi.nvim_win_get_height(win_id)
        local win_width = vi.nvim_win_get_width(win_id)
        local cursor_pos = vi.nvim_win_get_cursor(win_id)
        table.insert(_G.saved_window_state, {
            height = win_height,
            width = win_width,
            cursor = cursor_pos
        })
    end
end

-- Restore the sizes and cursor positions of all splits
local function restore_window_state()
    if #_G.saved_window_state == 0 then
        print("No window state saved.")
        return
    end

    local windows = vi.nvim_list_wins()
    for i, win_id in ipairs(windows) do
        if i > #_G.saved_window_state then
            break
        end
        local state = _G.saved_window_state[i]
        vi.nvim_win_set_height(win_id, state.height)
        vi.nvim_win_set_width(win_id, state.width)
        vi.nvim_win_set_cursor(win_id, state.cursor)
    end
end

-- Maximize
local function maximize_split()
    local win_id = vi.nvim_get_current_win()
    vi.nvim_win_set_height(win_id, vi.nvim_get_option('lines') - 2)
    vi.nvim_win_set_width(win_id, vi.nvim_get_option('columns') - 2)
end

local function save_and_maximize()
    save_window_state()  -- Save sizes and cursor positions
    maximize_split()    -- Maximize the current split
end

-- User commands to manually call these functions in Ex mode
vi.nvim_create_user_command('RestoreSizes', restore_window_state, {})
vi.nvim_create_user_command('SaveAndMaximize', save_and_maximize, {})
