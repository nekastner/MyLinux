return {

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "python", "javascript", "typescript", "java", "markdown" },
      highlight = { enable = true },
    },
    config = function(_, opts)
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
      end
    end,
  },

  -- Blink.cmp
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = true } },
        menu = { auto_show = true },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "lua_ls" }
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = { 'pyright', 'ts_ls', 'lua_ls' }

      for _, server_name in ipairs(servers) do
        vim.lsp.config(server_name, {
          capabilities = capabilities,
        })

        vim.lsp.enable(server_name)
      end

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show Doc" })
    end,
  },
}

