require("lazy").setup({
    spec = {
        { import = "plugins" },
    },

    install = {
        missing = false,
        colorscheme = { "gruvbox" }
    },
    performance = {
        rtp = {
            reset = false
        }
    }
})
