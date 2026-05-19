-- ~/.config/nvim/lua/plugins/snacks.lua
return {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000,
    lazy = false, -- snacks 需要尽早加载
    opts = {
        -- 需要的子模块在这里启用
        picker = {
            -- 全局 picker 默认配置
            layout = {
                preset = "default", -- 可选: "default", "vertical", "ivy", "dropdown" 等
            },
            -- 所有 picker 的默认选项
            defaults = {
                layout = {
                    cycle = true,
                    -- 使用默认预设的布局配置
                },
            },
            sources = {
                -- 这里可以自定义各个来源的行为
                files = {
                    hidden = false,
                    ignored = true,
                },
                grep = {
                    -- live_grep 的额外参数
                    additional_args = {},
                },
            },
        },
        -- 如果你还想启用其他 snacks 功能（都是可选的）：
        -- bigfile = { enabled = true },
        -- dashboard = { enabled = true },
        -- notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },

    },
    keys = {
        { "<leader>ff", function() Snacks.picker.files() end, desc = "查找文件" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "全文搜索" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "查找缓冲区" },
        { "<leader>fh", function() Snacks.picker.help() end, desc = "查找帮助" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "最近文件" },
        -- LSP 相关（去掉注释即可启用）
        -- { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "文件符号" },
        -- { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "工作区符号" },
        -- { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "诊断信息" },
        -- { "<leader>fc", function() Snacks.picker.grep_word() end, desc = "搜索光标下单词" },
        -- Grep
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
        { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word" },
    },
}
