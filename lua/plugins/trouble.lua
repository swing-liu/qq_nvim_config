return {
    "folke/trouble.nvim",
    enabled = true,
    cmd = "Trouble",
    opts = {
        keys = {
            q = "close",
            ["<Esc>"] = "close",
        },
    },
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<CR>",
            desc = "打开/关闭诊断列表",
        },
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "当前文件诊断",
        },
    },
}
