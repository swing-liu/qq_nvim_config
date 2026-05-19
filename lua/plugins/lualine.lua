-- ~/.config/nvim/lua/plugins/lualine.lua

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    enabled = true,
    config = function()
        require("lualine").setup({
            -- 主题设置
            options = {
                theme = catppuccin,                               -- 使用 catppuccin 主题
                component_separators = { left = "", right = "" }, -- 组件分隔符
                section_separators = { left = "", right = "" },   -- 区块分隔符
                disabled_filetypes = {                            -- 禁用状态栏的文件类型
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,   -- 全局状态栏（所有窗口共享一个）
                refresh = {
                    statusline = 1000, -- 刷新频率（毫秒）
                    tabline = 1000,
                    winbar = 1000,
                },
            },

            -- 状态栏分区配置
            sections = {
                -- 左侧：模式、分支、文件信息
                lualine_a = { "mode" },           -- 模式（NORMAL, INSERT等）
                lualine_b = { "branch", "diff" }, -- Git 分支和差异
                lualine_c = {
                    { "filename", path = 1 },     -- 文件路径（1=相对路径）
                    "diagnostics",                -- LSP 诊断信息
                },

                -- 右侧：编码格式、位置、进度
                lualine_x = {
                    "encoding",             -- 文件编码（UTF-8等）
                    "fileformat",           -- 文件格式（unix/dos）
                    "filetype",             -- 文件类型（lua/python等）
                },
                lualine_y = { "progress" }, -- 文件进度（百分比）
                lualine_z = { "location" }, -- 光标位置（行:列）
            },

            -- 不活跃窗口的状态栏
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },

            -- 标签栏配置（可选）
            tabline = {},
            winbar = {},
            inactive_winbar = {},

            -- 扩展功能
            extensions = {
                "nvim-tree", -- 在文件树中显示状态栏
                -- "fzf",         -- fzf 支持（如果有）
                "quickfix",  -- 快速修复列表
            },
        })
    end,
}
