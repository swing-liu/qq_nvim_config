return {
    "stevearc/conform.nvim",
    enabled = true,
    opts = {
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                -- 也可以根据需要添加其他语言，比如 java, javascript 等
                -- java = { "google-java-format" },
            },
            -- 可选：配置保存时自动格式化
            format_on_save = {
                lsp_fallback = true, -- 如果 LSP 不支持格式化，则使用这里配置的工具
                timeout_ms = 500,
            },
        })
        -- 可选：设置手动格式化的快捷键
        vim.keymap.set("n", "<leader>F", function()
            require("conform").format({ async = true })
        end, { desc = "Format file" })
    end
}
