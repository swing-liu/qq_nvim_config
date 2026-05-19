return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            notify = false,
        })

        wk.register({
            ["<leader>a"] = { name = "+window left" },
            ["<leader>d"] = { name = "+window right" },
            ["<leader>s"] = { name = "+window down" },
            ["<leader>w"] = { name = "+window up" },
            ["<leader>n"] = { name = "+buffer next" },
            ["<leader>c"] = { name = "+buffer close" },
            ["<leader>q"] = { name = "+quit" },
            ["<leader>p"] = { name = "+paste" },
            [","] = { name = "+resize" },
        }, { mode = "n" })
    end,
}
