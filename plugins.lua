local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    --  config = function()
    --   vim.g.wakatime_api_key = vim.fn.system("pass show wakatime/api")
    -- end,
  },
  {
    "vim-crystal/vim-crystal",
    -- ft="crystal",
    event = "VeryLazy",
    -- lazy = false,
    config = function()
      -- vim.g.crystal_auto_format = 1
      vim.g.crystal_auto_format = 1
    end,
  },
  {
    'lianghx-319/ChatGPT.nvim',
    -- event = "VeryLazy",
    event = "BufRead",
    config = function()
      require("chatgpt").setup({
      -- async_api_key_cmd = "pass show 2dapi/token", 
      api_key_cmd = "pass show 2dapi/token",
      api_host_cmd = "pass show openai/host",
      -- OPENAI_API_HOST= "pass show openai/host",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
  },
    {'Exafunction/codeium.vim',
      event = "VeryLazy",
      -- event = "BufRead",
      config = function ()
        -- Change '<C-g>' here to any keycode you like.
        vim.keymap.set('i', '<C-h>', function () return vim.fn['codeium#Accept']() end, { expr = true })
        vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        vim.g.codeium_api_key = vim.fn.system("pass show codeium/api")
      end,
    },
   {'hashivim/vim-terraform',
      event = "BufRead",
    },
}

return plugins
