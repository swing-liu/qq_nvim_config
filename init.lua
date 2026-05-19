vim.env.HOME = os.getenv("HOME")

-- 配置入口
require("options")
require("keymaps")
require("config.lazy")
require("config.lsp-info")

require("auto_comment_c").setup({
    author = "swing.liu",
    email = "swing.liu@outlook.com",
})

require("auto_comment_c").setup({
    author = "swing.liu",
    email = "swing.liu@outlook.com",
})

-- 启用 Treesitter 高亮（新版需要手动调用 vim.treesitter.start()）
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gn",
    callback = function()
        vim.treesitter.start()
    end,
})

-- 修改幽灵文本颜色
vim.api.nvim_set_hl(0, 'CmpGhostText', { fg = '#B4BEFE', italic = true, bg = 'None' })

-- Hint行尾字改为灰色
-- vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#6c6c6c", italic = true })
-- vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "NONE" })

-- new/delete和if/for等一个颜色
vim.api.nvim_set_hl(0, "@lsp.type.operator.cpp", { link = "Statement" })

-- 将普通行号设置为偏暗的灰色 (例如 #808080)
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#808080' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = '#808080' })

vim.api.nvim_set_hl(0, "MatchParen", { bg = "#808080" })

-- 启动打开文件nvim-tree
vim.cmd("NvimTreeToggle")
