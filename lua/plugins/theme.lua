return {
    -- 主题插件
    {
        "tomasiser/vim-code-dark",
        lazy = false,    -- 立即加载，不要懒加载
        priority = 1000, -- 高优先级，确保颜色正确
        config = function()
            -- 可选配置（在 colorscheme 之前设置）
            vim.g.codedark_conservative = 0 -- 0=色彩丰富，1=更素净
            vim.g.codedark_italics = 1      -- 1=注释斜体，0=关闭
            vim.g.codedark_transparent = 1  -- 1=背景透明，0=不透明

            -- 应用主题
            vim.cmd.colorscheme("codedark")

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

            -- 让一些侧边栏元素背景也透明，保持视觉统一
            vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })      -- 行号区域
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })  -- 图标列（如 Git 标记、LSP 错误）
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) -- 文件末尾的 `~` 符号区域
        end,
    },

    -- 可选：如果你需要终端支持更好（kitty, alacritty 等）
    -- {
    --     "Mofiqul/dracula.nvim",
    --     enabled = false  -- 禁用示例
    -- },
}
