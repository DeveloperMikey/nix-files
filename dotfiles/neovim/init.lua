local cmp = require("cmp")
local telescope_builtin = require('telescope.builtin')

vim.o.relativenumber = true
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
vim.keymap.set('n', '<leader>q', function() 
  if vim.o.number then
  	vim.o.relativenumber = true
		vim.o.number = false
	else
		vim.o.number = true
		vim.o.relativenumber = false
  end
end, {silent = true, noremap = true})
vim.keymap.set('n', '<leader>Q', function() vim.o.number = false vim.o.relativenumber = false end, {silent = true, noremap = true})

cmp.setup({
	mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
  },
  {
		{ name = 'buffer' },
	})
})

require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}


require('colorizer').setup({})
require("nvim-autopairs").setup {}
require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}
require('neoscroll').setup()
require("diffview").setup({})

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

require("cheatsheet").setup({
    -- Whether to show bundled cheatsheets

    -- For generic cheatsheets like default, unicode, nerd-fonts, etc
    -- bundled_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- },
    bundled_cheatsheets = true,

    -- For plugin specific cheatsheets
    -- bundled_plugin_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- }
    bundled_plugin_cheatsheets = true,

    -- For bundled plugin cheatsheets, do not show a sheet if you
    -- don't have the plugin installed (searches runtimepath for
    -- same directory name)
    include_only_installed_plugins = true,

    -- Key mappings bound inside the telescope window
    telescope_mappings = {
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
    }
})
