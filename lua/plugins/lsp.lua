-- ~/.config/nvim/lua/plugins/lsp.lua

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
    },
    enabled = true,

    config = function()
        -- 新的 LSP 配置方式（Neovim 0.11+）
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- local capabilities = require("blink.cmp").get_lsp_capabilities()

        -- LSP 诊断显示配置
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
                severity = { min = vim.diagnostic.severity.WARN },
            },
            signs = {
                severity = { min = vim.diagnostic.severity.WARN },
            },
            underline = {
                severity = { min = vim.diagnostic.severity.WARN },
            },
            update_in_insert = false,
            severity_sort = true,
        })

        -- 诊断图标也就是行号前面的E、W等，是可以配置的

        -- vim.api.nvim_create_autocmd("BufEnter", {
        --     pattern = "*.log*",
        --     callback = function()
        --         vim.diagnostic.config({ virtual_text = false })
        --     end
        -- })

        -- 定义通用按键映射
        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            -- CursorHold: 支持 hover 就显示信息，否则什么都不做
            -- if client.server_capabilities.hoverProvider then
            --     vim.api.nvim_create_autocmd("CursorHold", {
            --         buffer = bufnr,
            --         callback = function()
            --             vim.lsp.buf.hover()
            --         end,
            --     })
            -- end

            -- t 跳转到声明或者定义
            vim.keymap.set("n", "t", function()
                -- 获取当前窗口的光标位置
                local current_win = vim.api.nvim_get_current_win()
                local current_pos = vim.api.nvim_win_get_cursor(current_win)

                -- 先尝试跳转到声明
                vim.lsp.buf.declaration()

                -- 检查是否跳转成功（光标位置是否改变）
                local new_pos = vim.api.nvim_win_get_cursor(current_win)
                if new_pos[1] == current_pos[1] and new_pos[2] == current_pos[2] then
                    -- 没有声明可跳转，尝试跳转到定义
                    vim.lsp.buf.definition()
                end
            end, bufopts)
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = 1 })
            end, bufopts)
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = -1 })
            end, bufopts)
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts)
        end

        -- gn 语言服务器
        vim.lsp.config.gn = {
            cmd = { "gn-language-server" },
            filetypes = { "gn" },
            root_markers = { ".gn", "BUILD.gn" }, -- GN 项目的根目录标识
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- C/C++ 语言服务器
        vim.lsp.config.clangd = {
            cmd = {
                "clangd",
                "--fallback-style=llvm",                        -- 没有配置时用 llvm 编码风格
                "--query-driver=/usr/bin/g++,/usr/bin/clang++", -- 允许 clangd 查询这些编译器的默认 include 路径
                "--header-insertion=iwyu",
                "--completion-style=detailed",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git", "CMakeLists.txt", ".gn" },
            settings = {
                clangd = {
                    -- 传给 clangd 的命令行参数
                    arguments = {
                        "--header-insertion=never",      -- 不自动插入头文件
                        "--completion-style=precise",    -- 补全更精确
                        "--function-arg-placeholders=0", -- 不显示函数参数占位符
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- Lua 语言服务器
        vim.lsp.config.lua_ls = {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- Python 语言服务器
        vim.lsp.config.pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_markers = { "pyproject.toml", "setup.py", ".git" },
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                    },
                },
            },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- TypeScript/JavaScript 语言服务器
        vim.lsp.config.ts_ls = {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "typescript", "javascript" },
            root_markers = { "package.json", "tsconfig.json", ".git" },
            capabilities = capabilities,
            on_attach = on_attach,
        }

        -- 启用这些 LSP 配置
        vim.lsp.enable("clangd")
        vim.lsp.enable("gn")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("ts_ls")
    end,
}
