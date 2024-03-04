local cmp = require("cmp")
local telescope_builtin = require('telescope.builtin')

vim.o.number = true
vim.o.background = "dark"
vim.opt.showmode = false
vim.wo.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

require("lualine").setup({
	icons_enabled = true,
	theme = 'gruvbox',
})

vim.keymap.set('n', '<leader>w', function() vim.cmd(':w') end, {silent = true, noremap = true})
vim.keymap.set('n', '<leader>q', function() vim.cmd(':q') end, {silent = true, noremap = true})

require('colorizer').setup()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
    },
    {
		{ name = 'buffer' },
	})
})



vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
