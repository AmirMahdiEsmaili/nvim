-- Install Packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Auto-recompile when this file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

-- Plugin management
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- File Explorer
  use 'nvim-tree/nvim-tree.lua'

  -- Status Line
  use 'nvim-lualine/lualine.nvim'

  -- Git Integration
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- Syntax Highlighting & Autocompletion
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  -- LSP Support
  use 'neovim/nvim-lspconfig'

  -- Terminal Integration
  use 'voldikss/vim-floaterm'

  -- Docker & YAML Tools
  use 'chr4/nginx.vim'
  use 'ekalinin/Dockerfile.vim'
  use 'pearofducks/ansible-vim'
  use 'yaml.vim'

  -- Markdown Support
  use 'plasticboy/vim-markdown'

  -- Auto Pairs
  use 'jiangmiao/auto-pairs'

  -- Gruvbox Theme
  use 'morhetz/gruvbox'

  -- If Packer was just installed
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.mouse = 'a'

-- Set background to black and configure theme
vim.opt.background = 'dark'
vim.cmd [[
  colorscheme gruvbox
  highlight Normal guibg=black
  highlight CursorLine guibg=black
  highlight Pmenu guibg=black guifg=green
  highlight PmenuSel guibg=green guifg=black
  highlight Visual guibg=green guifg=black
]]

-- Key Bindings
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':FloatermToggle<CR>', { noremap = true, silent = true })

-- Nvim Tree
require'nvim-tree'.setup {}

-- Lualine with Gruvbox theme
require('lualine').setup {
  options = { theme = 'gruvbox' }
}

-- Git Signs
require('gitsigns').setup()

-- LSP
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}  -- Python LSP
lspconfig.ansiblels.setup{}  -- Ansible LSP
lspconfig.dockerls.setup{}  -- Docker LSP
lspconfig.yamlls.setup{}  -- YAML LSP

