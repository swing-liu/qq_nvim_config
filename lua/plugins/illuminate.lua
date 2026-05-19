return {
    "RRethy/vim-illuminate",
    opts = {
        delay = 5,              -- 光标停留 200ms 后高亮
        under_cursor = true,    -- 高亮光标下的单词
        min_count_to_highlight = 1, -- 至少出现 1 次才高亮
        modes_denylist = { "i" }, -- 禁止插入时高亮
        providers = { "regex" }, -- 只使用正则匹配高亮
        -- providers = { "lsp", "treesitter", "regex" },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        -- 自定义高亮样式为黄色
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { fg = "#FFFF5F", bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { fg = "#FFFF5F", bold = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { fg = "#FFFF5F", bold = true })

        -- 搜索时不设置背景，保持一致
        vim.cmd("highlight Search guifg=#FFD75F guibg=NONE gui=bold")
        vim.cmd("highlight IncSearch guifg=#FFD75F guibg=NONE gui=bold")
        vim.cmd("highlight CurSearch guifg=#FFD75F guibg=NONE gui=bold")
    end,
}
