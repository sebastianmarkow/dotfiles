local icons = require('config.icons')

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        dependencies = {
          'williamboman/mason-lspconfig.nvim',
        },
        build = function()
          local lsp_servers = {
            'gopls',
            'rust_analyzer',
            'yamlls',
            'pylsp',
            'lua_ls',
            'helm_ls',
            'jsonls',
            'jq_lsp',
            'terraformls',
          }
          local tools = {
            'delve',
            'debugpy',
            'gitlint',
            'hadolint',
            'markdownlint',
            'ruff',
            'shellcheck',
            'tflint',
            'tfsec',
            'yamllint',
          }

          local mason_registry = require('mason-registry')
          local function install_ensured()
            for _, tool in ipairs(tools) do
              local p = mason_registry.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end
          mason_registry.refresh()
          install_ensured()
          require('mason-lspconfig').setup({
            ensure_installed = lsp_servers,
          })
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'j-hui/fidget.nvim',
      'SmiteshP/nvim-navic',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 0, source = false, prefix = '' },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
          },
        },
        severity_sort = true,
        float = {
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      },
      fidget = {
        notification = {
          window = {
            border = 'rounded',
          },
        },
      },
      servers = {
        yaml = {
          filetypes = { 'yaml' },
          settings = {
            schemaStore = {
              enable = true,
              url = 'https://www.schemastore.org/api/json/catalog.json',
            },
            schemas = {
              kubernetes = '*.yaml',
              ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
              ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
              ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
              ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
              ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
              ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
              ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
              ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
              ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
            },
            format = { enabled = false },
            -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
            -- see utils.custom_lsp_attach() for the workaround
            -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
            validate = false,
            completion = true,
            hover = true,
          },
        },
        gopls = {
          filetypes = { 'go' },
          settings = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { '-.git' },
            semanticTokens = true,
          },
        },
        lua_ls = {
          filetypes = { 'lua' },
          settings = {
            Lua = {
              telemetry = { enable = false },
              diagnostics = { globals = { 'vim' } },
              hint = { enable = true },
              workspace = {
                -- make language server aware of runtime files
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.stdpath('config') .. '/lua'] = true,
                },
              },
            },
          },
        },
        pylsp = {
          filetypes = { 'python' },
          settings = {
            pylsp = {
              plugins = {
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pylint = { enabled = true },
                ruff = { enabled = false },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pylsp_mypy = { enabled = true, report_progress = true, live_mode = false },
                jedi_completion = { fuzzy = true },
                isort = { enabled = true },
              },
            },
          },
        },
        rust_analzyer = { filetypes = { 'rust' }, settings = {} },
      },
    },
    config = function(_, opts)
      local navic = require('nvim-navic')

      local function on_attach(client, bufnr)
        local args = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap
        -- Example key mappings
        keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', args)
        keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', args)
        keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', args)
        keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', args)

        navic.attach(client, bufnr)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup()
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = (opts.servers[server_name] or {}).settings,
              filetypes = (opts.servers[server_name] or {}).filetypes,
            })
          end,
        },
      })
      require('fidget').setup(opts.fidget)
      vim.diagnostic.config(opts.diagnostics)
    end,
  },
  {
    'SmiteshP/nvim-navic',
    config = true,
  },
}
