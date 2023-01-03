local builtin = require('telescope.builtin')

local telescope = require('telescope')
telescope.setup{defaults = {path_display = {"truncate"}}}

vim.keymap.set("n", "<Space>ff", builtin.find_files, {})
vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Space>fb", builtin.buffers, {})
vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})
