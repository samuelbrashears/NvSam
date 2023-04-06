vim.o.relativenumber = true
vim.api.nvim_set_keymap('n', '<leader>yy', ':normal! ggVGy+<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pf', ':normal! ggVG"+p<CR>', {noremap = true, silent = true})
