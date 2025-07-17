return {
    "neovim/nvim-lspconfig",
    dir = require("lazy-nix-helper").get_plugin_path("nvim-lspconfig"),
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.nil_ls.setup({
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                capabilities,
                {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }
            ),
            settings = {
                ['nil'] = {
                    formatting = {
                        command = { "nixfmt" }
                    },
                    nix = {
                        flake = {
                            autoArchive = true,
                            autoEvalInputs = true,
                        }
                    }
                }
            }
        })
    end
}
