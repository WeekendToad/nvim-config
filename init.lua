require("nvim-tree").setup()
require("WeekendToad.core.options")
require("WeekendToad.core.keymaps")
require("WeekendToad.core.colorscheme")
require("WeekendToad.plugins-setup")
require("WeekendToad.plugins/harpoon")
require("WeekendToad.plugins/nvim-telescope")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.cmd('nnoremap <space>e :NvimTreeToggle<CR>')
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_close = 1
