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
            'basedpyright',
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
              if not p:is_installed() then p:install() end
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
              ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] =
              '*api*.{yml,yaml}',
              ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
              '*docker-compose*.{yml,yaml}',
              ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] =
              '*flow*.{yml,yaml}',
            },
            format = { enabled = false },
            -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
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
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.stdpath('config') .. '/lua'] = true,
                },
              },
            },
          },
        },
        basedpyright = {
          filetypes = { 'python' },
          settings = {
            bpythonasedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              }
            }
          }
        },
        rust_analzyer = { filetypes = { 'rust' }, settings = {} },
      },
    },
    config = function(_, opts)
      local function on_attach(client, bufnr)
        local keymap = vim.api.nvim_buf_set_keymap
        local args = { noremap = true, silent = true }

        keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', args)
        keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', args)
        keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', args)
        keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', args)

        require('nvim-navic').attach(client, bufnr)
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
      vim.diagnostic.config(opts.diagnostics)
    end,
  },
}
