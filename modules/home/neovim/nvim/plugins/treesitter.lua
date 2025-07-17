return {
    "nvim-treesitter/nvim-treesitter",
    dir = require("lazy-nix-helper").get_plugin_path("nvim-treesitter"),
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = false,
            highlight = {
                enable = true,
            }
        }
    end
}
