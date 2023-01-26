require("nvim-tree").setup()
require("WeekendToad.core.options")
require("WeekendToad.core.keymaps")
require("WeekendToad.core.colorscheme")
require("WeekendToad.plugins-setup")
require("WeekendToad.plugins/harpoon")
require("WeekendToad.plugins/nvim-telescope")
require("WeekendToad.plugins/lspconfig")
require("WeekendToad.plugins/toggleterm")
require('lualine').setup()
require('WeekendToad.plugins/test')
require"fidget".setup{}
require("mason").setup()
require("lspconfig").tsserver.setup{}
require('gitsigns').setup{}

require'luasnip'.filetype_extend("tsx", {"typescript"})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.cmd('nnoremap <space>e :NvimTreeToggle<CR>')
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_close = 1
