return {
    "ellisonleao/gruvbox.nvim",
    dir = require("lazy-nix-helper").get_plugin_path("gruvbox.nvim"),
    opts = function()
        vim.cmd.colorscheme("gruvbox")
    end
}
