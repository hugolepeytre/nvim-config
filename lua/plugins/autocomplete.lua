vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local cmp = require('cmp')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        -- REQUIRED - doesn't work without a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help', keyword_length = 1},
        { name = 'nvim_lsp', keyword_length = 1},
        { name = 'buffer', keyword_length = 3},
        { name = 'path', keyword_length = 3},
        { name = 'luasnip' },
    }),
    formatting = {
        -- Order of fields matters
        fields = {'kind', 'abbr', 'menu'},
        format = function(entry, item)
            local max_item_length = 40
            local menu_icon = {
                nvim_lsp = 'λ',
                nvim_lsp_signature_help = 'Σ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = 'Π',
            }

            item.menu = menu_icon[entry.source.name]
            item.abbr = string.sub(item.abbr, 1, max_item_length)
            return item
        end,
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    }
})
