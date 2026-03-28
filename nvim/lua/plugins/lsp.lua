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
          ':MasonInstall codelldb',
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
          ':MasonInstall ruff',
          ':MasonInstall rust-analyzer',
          ':MasonInstall shellcheck',
          ':MasonInstall stylua',
          ':MasonInstall taplo',
          ':MasonInstall terraform-ls',
          ':MasonInstall tflint',
          ':MasonInstall tfsec',
          ':MasonInstall yamlfmt',
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

      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end
        map('gd', vim.lsp.buf.definition, 'Goto Definition')
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
        map('gi', vim.lsp.buf.implementation, 'Goto Implementation')
        map('gr', vim.lsp.buf.references, 'Goto References')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<leader>lr', vim.lsp.buf.rename, 'Rename')
        map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
        map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
        map('<leader>lf', vim.diagnostic.open_float, 'Show Diagnostic Float')
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, 'blink.cmp')
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server_ok, server_config = pcall(require, 'lsp.' .. server_name)
            local config = server_ok and server_config or {}
            config.on_attach = on_attach
            config.capabilities = capabilities
            require('lspconfig')[server_name].setup(config)
          end,
        },
      })

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
