return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      'rafamadriz/friendly-snippets',
      'ray-x/cmp-treesitter',
    },
    version = 'v2.*',
    enabled = false,
    event = { 'VeryLazy', 'LspAttach' },
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Esc>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 100 },
          { name = 'nvim_lsp_signature_help', priority = 100 },
          { name = 'treesitter', priority = 50, keyword_length = 3 },
          { name = 'path', priority = 25 },
        }),
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 80,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                path = '[Path]',
                treesitter = '[Treesitter]',
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'cmdline' } }),
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 80,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
              vim_item.menu = ({ cmdline = '[CMD]' })[entry.source.name]
              return vim_item
            end,
          }),
        },
      })
    end,
  },
}
