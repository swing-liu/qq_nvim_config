-- ~/.config/nvim/lua/plugins/opencode.lua
-- opencode.nvim 插件配置（lazy.nvim）

return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- 使用最新稳定版本
    enabled = true,

    -- 推荐安装 snacks.nvim 以增强 ask() 和 select() 体验（可选）
    dependencies = {
        {
            "folke/snacks.nvim",
            optional = true,
            opts = {
                -- 增强 ask() 输入框
                input = {},
                -- 增强 select() 选择器，添加快捷键 <A-a> 可直接发送选中内容给 opencode
                picker = {
                    actions = {
                        opencode_send = function(...)
                            return require("opencode").snacks_picker_send(...)
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<A-a>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            },
        },
    },

    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- ── 服务器配置 ──────────────────────────────────────────────────────
            -- 默认会在内嵌终端自动启动 opencode，无需额外配置
            -- 如果你想用 snacks.terminal 管理窗口，取消下方注释：

            -- server = {
            --     start = function()
            --         require("snacks.terminal").open("opencode --port", {
            --             win = { position = "right", enter = false },
            --         })
            --     end,
            --     stop = function()
            --         require("snacks.terminal").get("opencode --port"):close()
            --     end,
            --     toggle = function()
            --         require("snacks.terminal").toggle("opencode --port", {
            --             win = { position = "right", enter = false },
            --         })
            --     end,
            -- },

            -- ── 事件配置 ────────────────────────────────────────────────────────
            events = {
                -- opencode 编辑文件后自动重新加载对应 buffer（需要 vim.o.autoread = true）
                reload = true,
            },

            -- ── 实验性 LSP（可选）────────────────────────────────────────────────
            -- 开启后支持 hover 查询、code action 等 LSP 功能
            -- lsp = { enabled = true },
        }

        -- autoread 配合 events.reload 使用，opencode 修改文件后 Neovim 自动刷新
        vim.o.autoread = true

        -- ── 快捷键配置 ──────────────────────────────────────────────────────────
        --
        -- 注意：<C-a> 默认是 Neovim 的数字自增，<C-x> 是数字自减
        -- 下方最后两行将它们重新映射到 + 和 - 以避免冲突
        --
        --  <C-a>  →  向 opencode 发送当前选区 / 光标位置的内容并立即提交
        --  <C-x>  →  打开 opencode 操作选择面板（select）
        --  <C-i>  →  切换 opencode 面板显示 / 隐藏（normal 和 terminal 模式下均可用）
        --
        vim.keymap.set(
            { "n", "x" },
            "<C-a>",
            function() require("opencode").ask("@this: ", { submit = true }) end,
            { desc = "Ask opencode (发送选区)" }
        )

        vim.keymap.set(
            { "n", "x" },
            "<C-x>",
            function() require("opencode").select() end,
            { desc = "opencode 操作面板" }
        )

        vim.keymap.set(
            { "n", "t" },
            "<C-c>",
            function() require("opencode").toggle() end,
            { desc = "切换 opencode 面板" }
        )

        -- ── Operator 映射（Vim-y 风格，支持 range 和 dot-repeat）──────────────
        --  go{motion}  →  将 motion 范围的内容发给 opencode
        --  goo         →  将当前行发给 opencode（类似 dd/yy 的双字符操作）
        vim.keymap.set(
            { "n", "x" },
            "go",
            function() return require("opencode").operator("@this ") end,
            { desc = "发送范围给 opencode", expr = true }
        )

        vim.keymap.set(
            "n",
            "goo",
            function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "发送当前行给 opencode", expr = true }
        )

        -- ── 滚动翻页（在 Neovim 编辑模式下控制 opencode 面板滚动）───────────────
        --  <S-C-u>  →  opencode 面板上翻半页
        --  <S-C-d>  →  opencode 面板下翻半页
        vim.keymap.set(
            "n",
            "<S-C-u>",
            function() require("opencode").command("session.half.page.up") end,
            { desc = "opencode 上翻半页" }
        )

        vim.keymap.set(
            "n",
            "<S-C-d>",
            function() require("opencode").command("session.half.page.down") end,
            { desc = "opencode 下翻半页" }
        )

        -- ── 恢复被占用的 Neovim 原生快捷键 ────────────────────────────────────
        -- 因为 <C-a> 和 <C-x> 被 opencode 占用，用 + / - 代替数字增减
        vim.keymap.set("n", "+", "<C-a>", { desc = "数字自增", noremap = true })
        vim.keymap.set("n", "-", "<C-x>", { desc = "数字自减", noremap = true })

        -- ── Statusline 集成（可选，以 lualine 为例）────────────────────────────
        -- 在 lualine 配置中加入以下内容即可在状态栏显示 opencode 状态：
        --
        -- require("lualine").setup({
        --   sections = {
        --     lualine_z = { { require("opencode").statusline } },
        --   },
        -- })
    end,
}
