vim.o.relativenumber = true
vim.api.nvim_set_keymap('n', '<leader>yy', ':normal! ggVG<CR><leader>c<CR>', {noremap = false, silent = true})

vim.api.nvim_set_keymap('n', '<leader>lp', ':normal! ggVGd"_dd<CR>:startinsert<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fz', ':Telescope current_buffer_fuzzy_find<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ko', ':Telescope lsp_document_symbols<CR>', {noremap = true, silent = true})

-- Add the 'add_instant_code' function
-- Add the lines above and below the current line
function add_lines()
  local line = vim.api.nvim_win_get_cursor(0)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(bufnr, line[1] - 1, line[1] - 1, false, {"let curr = Instant::now();"})
  vim.api.nvim_buf_set_lines(bufnr, line[1] + 1, line[1] + 1, false, {"println!(\"{:?}\", curr.elapsed());"})
  vim.cmd("normal! jw3l")
  vim.cmd('startinsert')
end


-- Create a keymap for the 'add_lines' and 'move_cursor' functions
vim.api.nvim_set_keymap('n', '<leader>ti', ':lua add_lines()<CR>', {noremap = true, silent = true})

