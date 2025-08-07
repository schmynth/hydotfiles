local builtin = require("telescope.builtin")

-- find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- file browser
vim.keymap.set('n', '<space>fb', ':Telescope file_browser<CR>')
-- grep files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- undotree
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = "Toggle Undotree" })
-- nvim-tree
vim.keymap.set('n', '<C-h>', ':NvimTreeToggle<CR>', { desc = "Toggle Explorer SideBar" })
-- code_action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "show code action" })
-- go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "go to definition" })
