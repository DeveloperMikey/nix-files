vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.relativenumber = true
vim.o.background = "dark"
vim.opt.showmode = false
vim.wo.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.cmd('colorscheme gruvbox')

-- Line number keybinds
vim.keymap.set('n', '<leader>q', function()
	if vim.o.number then
		vim.o.relativenumber = true
		vim.o.number = false
	else
		vim.o.number = true
		vim.o.relativenumber = false
	end
end, { silent = true, noremap = true })
vim.keymap.set('n', '<leader>Q', function()
	vim.o.number = false
	vim.o.relativenumber = false
end, { silent = true, noremap = true })


require("plugins.barbar")
require("plugins.oil")
require("plugins.cmp")
require("plugins.lualine")
require("plugins.cursorline")
require("colorizer").setup({})
require("nvim-autopairs").setup()
require("gitblame").setup()
require("diffview").setup()
require("plugins.conform")
require("plugins.cheatsheet")
require("plugins.telescope")
require('neogit').setup{}
