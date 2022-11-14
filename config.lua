-- General
lvim.log.level = 'warn'
lvim.format_on_save.enabled = true
lvim.colorscheme = 'lunar'

-- Remap space as the leader key.
lvim.leader = 'space'

-- Keymappings
-- View all the defaults by pressing <Leader>Lk

-- Press jk fast to enter
lvim.keys.insert_mode['jk'] = '<Esc>'

-- Toggle explorer
lvim.keys.normal_mode['<C-b>'] = ':NvimTreeToggle<CR>'

-- Navigate windows (Not working now)
lvim.keys.normal_mode['<C-h>'] = '<C-w>h'
lvim.keys.normal_mode['<C-j>'] = '<C-w>j'
lvim.keys.normal_mode['<C-l>'] = '<C-w>l'
lvim.keys.normal_mode['<C-k>'] = '<C-w>k'

-- Save the file
lvim.keys.normal_mode['<C-s>'] = ':w<CR>'

-- Copy the whole file
lvim.keys.normal_mode['<C-a>'] = ':w<CR>:%w !pbcopy<CR><CR>'

-- Navigate buffers
lvim.keys.normal_mode['<S-l>'] = ':BufferLineCycleNext<CR>'
lvim.keys.normal_mode['<S-h>'] = ':BufferLineCyclePrev<CR>'
lvim.keys.normal_mode['<C-w>'] = ':BufferKill<CR>'

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, 'telescope.actions')
lvim.builtin.telescope.defaults.mappings = {
  -- insert mode
  i = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
    ['<C-n>'] = actions.cycle_history_next,
    ['<C-p>'] = actions.cycle_history_prev,
  },
  -- normal mode
  n = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix.
lvim.builtin.which_key.mappings['P'] = { ':Telescope projects<CR>', 'Projects' }
lvim.builtin.which_key.mappings['t'] = {
  name = '+Trouble',
  r = { ':Trouble lsp_references<CR>', 'References' },
  f = { ':Trouble lsp_definitions<CR>', 'Definitions' },
  d = { ':Trouble document_diagnostics<CR>', 'Diagnostics' },
  q = { ':rouble quickfix<CR>', 'QuickFix' },
  l = { ':Trouble loclist<CR>', 'LocationList' },
  w = { ':Trouble workspace_diagnostics<CR>', 'Workspace Diagnostics' },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = 'dashboard'
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = 'left'
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- If you don't want all the parsers change this to a table of the ones you want.
lvim.builtin.treesitter.ensure_installed = {
  'bash',
  'c',
  'javascript',
  'json',
  'lua',
  'python',
  'typescript',
  'tsx',
  'css',
  'rust',
  'java',
  'yaml',
}

lvim.builtin.treesitter.ignore_install = { 'haskell' }
lvim.builtin.treesitter.highlight.enable = true

-- Generic LSP settings
-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  'sumneko_lua',
  'jsonls',
}

-- Disable automatic installation of servers.
lvim.lsp.installer.setup.automatic_installation = false

-- Set a formatter for each language.
-- This will override the language server formatting capabilities if it exists.
local formatters = require 'lvim.lsp.null-ls.formatters'
formatters.setup {
  -- Each formatter accepts a list of options identical to:
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  {
    command = 'clang-format',
    filetypes = { 'cpp', 'java' },
  },
  {
    command = 'autopep8',
    filetypes = { 'python' },
    extra_args = { '--indent-size=2' }, -- Cannot contain whitespaces.
  },
  {
    command = 'isort',
    filetypes = { 'python' },
  },
  {
    command = 'prettier',
    extra_args = { '--print-with=100' },
    filetypes = { 'typescript', 'typescriptreact' },
  },
}

-- Set additional linters
local linters = require 'lvim.lsp.null-ls.linters'
linters.setup {
  {
    command = 'flake8',
    filetypes = { 'python' },
  },
  {
    command = 'shellcheck',
    extra_args = { '--severity', 'warning' },
  },
  {
    command = 'codespell',
    filetypes = { 'javascript', 'python' },
  },
}

-- Additional Plugins
lvim.plugins = {
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = { '*.json', '*.jsonc' },
--   -- enable wrap mode for json files only
--   command = 'setlocal wrap',
-- })
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'zsh',
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require('nvim-treesitter.highlight').attach(0, 'bash')
--   end,
-- }
