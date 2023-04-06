  local on_attach = require("plugins.configs.lspconfig").on_attach
  local capabilities = require("plugins.configs.lspconfig").capabilities

  local lspconfig = require "lspconfig"

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"rust"},
    root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  })

  vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
  vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
  vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
  require('leap').add_default_mappings()
  -- Enable Rust parser in nvim-treesitter
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {"rust"}, -- Install Rust parser
    highlight = {
      enable = true, -- Enable syntax highlighting
    },
    indent = {
      enable = true, -- Enable indentation
    },
  }

