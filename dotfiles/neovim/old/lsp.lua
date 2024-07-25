-- has to before be lspconfig
require("neodev").setup({
	override = function(root_dir, library)
    if root_dir == "/home/mike/nix" then
      library.enabled = true
      library.plugins = true
    end
  end,
})

local lspconfig = require("lspconfig")

lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

--nix script
lspconfig.nil_ls.setup{}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig['nil_ls'].setup {
	capabilities = capabilities
}

--lua
lspconfig.lua_ls.setup({})
