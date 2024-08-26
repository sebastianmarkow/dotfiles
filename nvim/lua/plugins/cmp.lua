return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "LspAttach" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            "windwp/nvim-autopairs",
            -- "zbirenbaum/copilot-cmp",
            -- { "zbirenbaum/copilot.lua", build = ":Copilot auth" },
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            -- local copilot = require("copilot")
            -- local copilot_cmp = require("copilot_cmp")
            -- local copilot_cmp_comparators = require("copilot_cmp.comparators")

            -- copilot.setup({
            --     panel = {
            --         enabled = false,
            --     },
            --     suggestion = {
            --         enabled = false,
            --     },
            --     filetypes = {
            --         yaml = true,
            --         markdown = false,
            --         help = false,
            --         gitcommit = false,
            --         gitrebase = false,
            --         hgcommit = false,
            --         svn = false,
            --         cvs = false,
            --         ["."] = false,
            --     },
            --     copilot_node_command = "node",
            --     server_opts_overrides = {},
            -- })

            -- copilot_cmp.setup()

            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        -- copilot_cmp_comparators.prioritize,
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                sources = {
                    -- { name = "copilot", priority = 100 },
                    { name = "nvim_lsp", priority = 100 },
                    { name = "nvim_lua", priority = 100 },
                    { name = "nvim_lsp_signature_help", priority = 100 },
                    { name = "luasnip", keyword_length = 3, priority = 100 },
                    { name = "buffer", keyword_length = 3, priority = 50 },
                    { name = "tmux", keyword_length = 3, priority = 50 },
                    { name = "path", keyword_length = 3, priority = 25 },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = lspkind.cmp_format({
                        mode = "symbol_text", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                        -- symbol_map = { Copilot = "" },
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                        before = function(entry, vim_item)
                            return vim_item
                        end,
                    }),
                },
            })
        end,
    },
}
