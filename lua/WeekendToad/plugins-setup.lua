-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed
vim.cmd[[ 
augroup test
autocmd!
autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
augroup end
]]
-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
augroup test
autocmd!
autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
augroup end
]])
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local status, packer = pcall(require, "packer")
if not status then
  return
end
return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("bluz71/vim-nightfly-guicolors")

use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

  use {
    'lewis6991/gitsigns.nvim',
  }


use{ 'hrsh7th/cmp-buffer'}
use{ 'hrsh7th/cmp-path'}
use{ 'hrsh7th/cmp-cmdline'}

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  use {
    "akinsho/toggleterm.nvim", tag = '*', 
  }
  use { 'j-hui/fidget.nvim' }
  -- use {
  --   "hrsh7th/nvim-cmp",
  --   requires = {
  --     "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
  --     'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
  --     'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
  --     'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
  --   }
  -- }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  use { "tpope/vim-fugitive" }
  use {"tpope/vim-commentary"}
  use { "ellisonleao/gruvbox.nvim" }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use { 'nvim-lua/plenary.nvim' }
  use { 'ThePrimeagen/harpoon' }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

