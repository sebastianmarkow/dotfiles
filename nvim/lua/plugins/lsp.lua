return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      {
        'SmiteshP/nvim-navic',
        opts = {
          lsp = {
            auto_attach = true,
          }
        },
      },
      {
        'mason-org/mason.nvim',
        build = {
          ':MasonUpdate',
          ':MasonInstall basedpyright',
          ':MasonInstall debugpy',
          ':MasonInstall delve',
          ':MasonInstall gitlint',
          ':MasonInstall goimports',
          ':MasonInstall gopls',
          ':MasonInstall hadolint',
          ':MasonInstall helm-ls',
          ':MasonInstall json-lsp',
          ':MasonInstall lua-language-server',
          ':MasonInstall markdownlint',
          ':MasonInstall python-lsp-server',
          ':MasonInstall ruff',
          ':MasonInstall rust-analyzer',
          ':MasonInstall shellcheck',
          ':MasonInstall stylua',
          ':MasonInstall taplo',
          ':MasonInstall terraform-ls',
          ':MasonInstall tflint',
          ':MasonInstall tfsec',
          ':MasonInstall yamllint',
        },
        opts = {},
      },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = true,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
          },
        },
      })
    end,
  },
}
