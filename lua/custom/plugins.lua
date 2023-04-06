local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "ggandor/lightspeed.nvim",
    lazy = false,
  },
  {
    "ojroques/nvim-osc52",
    lazy = false,
  }
}
return plugins
