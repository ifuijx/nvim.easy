vim.o['expandtab'] = true
vim.o['autoindent'] = true
vim.o['tabstop'] = 4
vim.o['shiftwidth'] = 4
vim.o['softtabstop'] = 4
vim.o['number'] = true

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            {
                'nvim-treesitter/nvim-treesitter',
                run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
            },
            -- neovim LSP
            -- devicons

            -- Binary
            -- BurntSushi/ripgrep is required for `live_grep` and `grep_string`
            -- and is the first priority for `find_files`
            -- sharkdp/fd (finder)
        }
    }

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    use {
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
            require('catppuccin').setup({
                transparent_background = true,
            })
            vim.api.nvim_command 'colorscheme catppuccin'
            vim.notify('hello')
        end
    }
end)

-- vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha
-- require('catppuccin').setup()
-- vim.api.nvim_command 'colorscheme catppuccin'

-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--     group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--     callback = function()
--         vim.opt.foldmethod = 'expr'
--         vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--     end
-- })

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.g.mapleader = ','

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'fd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'fr', builtin.lsp_references, {})

local cmp = require('cmp')

cmp.setup {
    sources = {
        { name = 'nvim_lsp' }
    },
--     mapping = cmp.mapping.preset.insert({
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-e>'] = cmp.mapping.close(),
--         ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif require('luasnip').jumpable(-1) then
--                 vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--     }),
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}

