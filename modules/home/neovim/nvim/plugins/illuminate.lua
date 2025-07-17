return {
    "RRethy/vim-illuminate",
    dir = require("lazy-nix-helper").get_plugin_path("vim-illuminate"),
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        delay = 100,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp", "treesitter", "regex" },
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        local function set_highlights()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })
        end

        set_highlights()

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = set_highlights,
        })

        local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](false)
            end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
        end

        map("]]", "next")
        map("[[", "prev")

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]]", "next", buffer)
                map("[[", "prev", buffer)
            end,
        })
    end,
    keys = {
        { "]]", desc = "Next Reference" },
        { "[[", desc = "Prev Reference" },
    },
}
