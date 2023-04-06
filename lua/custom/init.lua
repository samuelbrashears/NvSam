vim.o.relativenumber = true
vim.api.nvim_set_keymap('n', '<leader>yy', ':normal! ggVGy+<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>pf', ':normal! ggVG"+p<CR>', {noremap = true, silent = true})
local function check_and_install_rust_parser()
  local parsers = require('nvim-treesitter.parsers').get_parser_configs()
  if not parsers.rust then
    vim.cmd('TSInstall rust')
  end
end

-- Defer Rust parser installation until Neovim is fully loaded
vim.defer_fn(check_and_install_rust_parser, 0)

