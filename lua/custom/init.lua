vim.o.relativenumber = true
vim.api.nvim_set_keymap('n', '<leader>yy', ':normal! ggVG<CR><leader>c<CR>', {noremap = false, silent = true})

vim.api.nvim_set_keymap('n', '<leader>lp', ':normal! ggVGd"_dd<CR>:startinsert<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>kp', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ko', ':Telescope lsp_document_symbols<CR>', {noremap = true, silent = true})


