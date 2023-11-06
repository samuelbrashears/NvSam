local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
      -- vim.g.rustfmt_options = '--edition 2021'
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
  },
  {
    "ojroques/nvim-osc52",
    lazy = false,
  },
  {
    "alexxi19/share.nvim",
    lazy = false
  }
 -- {
  --   "nvim-neorg/neorg",
  --   run = ":Neorg sync-parsers", -- This is the important bit!
  --   lazy = false,
  --   config = function()
  --       require("neorg").setup {
  --         load = {
  --           ["core.defaults"] = {},
  --           ["core.dirman"] = {
  --             config = {
  --               workspaces = {
  --                 work = "~Documents/notes"
  --               }
  --             }
  --           }
  --         }
  --       }
  --   end,
  -- }
}
return plugins
