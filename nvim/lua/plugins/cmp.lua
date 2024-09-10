return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'rafamadriz/friendly-snippets',
      'ray-x/cmp-treesitter',
      'saadparwaiz1/cmp_luasnip'
    },
    version = 'v2.*',
    event = {'InsertEnter', 'LspAttach'},
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      luasnip.config.setup({})
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup(
        {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end
          },
          window = {completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered()},
          completion = {completeopt = 'menu,menuone,noinsert'},
          mapping = cmp.mapping.preset.insert(
            {
              ['<C-n>'] = cmp.mapping.select_next_item(),
              ['<C-p>'] = cmp.mapping.select_prev_item(),
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
              ['<Tab>'] = cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, {'i', 's'}
              ),
              ['<S-Tab>'] = cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, {'i', 's'}
              )
            }
          ),
          sorting = {
            priority_weight = 2,
            comparators = {
              cmp.config.compare.offset,
              cmp.config.compare.exact,
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.kind,
              cmp.config.compare.sort_text,
              cmp.config.compare.length,
              cmp.config.compare.order
            }
          },
          sources = cmp.config.sources(
            {
              {name = 'nvim_lsp', prioity = 100},
              {name = 'nvim_lsp_signature_help', priority = 100},
              {name = 'luasnip', priority = 80},
              {name = 'treesitter', priority = 50, keyword_length = 3},
              {name = 'path', priority = 25}
            }
          ),
          formatting = {
            fields = {'abbr', 'kind', 'menu'},
            format = lspkind.cmp_format(
              {
                mode = 'symbol_text',
                maxwidth = 80,
                ellipsis_char = '...',
                show_labelDetails = true,
                before = function(entry, vim_item)
                  vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    luasnip = '[Snippet]',
                    path = '[Path]',
                    treesitter = '[Tresitter]'
                  })[entry.source.name]
                  return vim_item
                end
              }
            )
          }
        }
      )
    end
  }
}
