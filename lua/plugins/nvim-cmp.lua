-- ~/.config/nvim/lua/plugins/cmp.lua

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    enabled = true,
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- 代码片段加载（可选）
        -- require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            -- 补全行为
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            -- 补全来源（优先级从高到低）
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- LSP 优先
                { name = "luasnip" },  -- 代码片段
            }, {
                { name = "buffer" },   -- 当前缓冲区
                { name = "path" },     -- 文件路径
            }),

            -- 快捷键映射
            mapping = cmp.mapping.preset.insert({
                -- 确认补全
                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                -- 上下选择
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- 滚动文档
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),

                -- 手动触发补全
                ["<C-Space>"] = cmp.mapping.complete(),

                -- 跳转到下一个代码片段占位符
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end),

                -- 跳转到上一个
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),
            }),
            -- 显示样式
            formatting = {
                format = require("cmp").format,
            },

            performance = {
                max_view_entries = 20, -- 限制显示的条目数量
            },

            -- 补全窗口边界
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- 实验性功能
            experimental = {
                -- ghost_text = true,  -- 幽灵文本提示
                ghost_text = {
                    hl_group = "CmpGhostText",
                }
            },
        })

        -- 命令行补全（单独配置）
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = {
                disallow_partial_matching = false,
                disallow_fuzzy_matching = false,
                disallow_fullfuzzy_matching = false,
                disallow_prefix_unmatching = false,
                -- 这里可以设置最少字符数
                min_chars = 2,
            },
            performance = {
                max_view_entries = 20, -- 限制显示的条目数量
            },
        })
    end,
}
