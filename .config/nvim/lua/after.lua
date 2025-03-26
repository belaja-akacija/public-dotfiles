local keymap = vim.api.nvim_set_keymap;

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua", "commonlisp"},
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
}

-- vlime window settings

vim.cmd[[
let g:vlime_window_settings = {
  \ "arglist": {
    \ "pos": "topleft",
    \ "size": 1,
    \ "vertical": v:false
  \ },
  \ "repl": {
    \ "pos": "aboveleft",
    \ "size": winheight(".") / 5
  \ },
  \ "sldb": {
    \ "pos": "aboveleft",
    \ "size": 5
\ }
\ }
]]

-- Harpoon settings

keymap('n', '<C-t>', ':lua require("harpoon.ui").nav_next()<CR>', {noremap = true, silent = true});
keymap('n', '<C-n>', ':lua require("harpoon.ui").nav_prev()<CR>', {noremap = true, silent = true});
--keymap('n', '<C-c>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {noremap = true, silent = true});
keymap('n', '<C-g>', ':lua require("harpoon.mark").add_file()<CR>', {noremap = true, silent = true});

-- LSP settings

--local lsp = require('lsp-zero').preset({})

--lsp.on_attach(function(client, bufnr)
  --lsp.default_keymaps({buffer = bufnr})
--end)

--lsp.setup()

--require('lspconfig.configs').millet = {
  --default_config = {
    --name = 'millet',
    --cmd = {'millet'},
    --filetypes = {'sml'},
    --root_dir = require('lspconfig.util').root_pattern({'main.sml'})
  --}
--}

--require('lspconfig').millet.setup({})

--vim.cmd([[
     --let g:opamshare = substitute(system('opam var share'),'\n$','','''')
     --execute "set rtp+=" . g:opamshare . "/merlin/vim"]]);


-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()


--local rt = require("rust-tools");

--rt.setup({
  --server = {
    --on_attach = function(_, bufnr)
    ---- Hover actions
    --vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, {buffer = bufnr});
    ---- Code action groups
    --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {buffer = bufnr});
  --end,
  --},
--})

--require 'lspconfig'.rust_analyzer.setup{};

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})


--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])



-- Treesitter folding
--vim.wo.foldmethod = 'expr'
--vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

local bufnr = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd(
{"Filetype"},
{pattern = "*.rs",
callback = function()
vim.keymap.set(
  'n',
  '`',
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)
vim.keymap.set(
  'n',
  'K',  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
'n',
'<F5>',
function()
  vim.cmd.RustLsp('runnables')
end,
{ silent = true, buffer = bufnr }
)

vim.keymap.set(
'n',
'<F6>',
function()
  vim.cmd.RustLsp('debuggables')
end,
{ silent = true, buffer = bufnr }
)
end
})



vim.g.rustaceanvim = {
  tools = {
    hover_actions = {
      auto_focus = true
    }
  },
  server = {
    on_attach = function(client, bufnr)
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { 0 });
      end
    end,
    default_settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = true
        }
      }
    }
  }
}


-- Treesitter Plugin Setup
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

local dap = require("dap");

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

require 'lspconfig'.lua_ls.setup {};



--require 'lspconfig'.csharp_ls.setup{
require 'lspconfig'.omnisharp.setup{
  --settings = {
    --server = {
      --on_attach = function(client, bufnr)
        --if vim.lsp.inlay_hint then
          --vim.lsp.inlay_hint.enable(true, { 0 });
        --end
      --end,
    --}
  --}
};

require 'todo-comments'.setup();
