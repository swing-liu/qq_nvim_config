return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- 自动更新注册表
        cmd = "Mason",          -- 延迟加载，仅调用相关命令时再完全加载
        config = function()
            require("mason").setup()
        end,
    },
    -- 如果你希望 mason-lspconfig 能自动安装配置好的语言服务器，可以保留这个
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        enabled = true,
        config = function()
            require("mason-lspconfig").setup({
                -- 自动安装的语言服务器列表
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "clangd",
                    "ts_ls",
                    -- "gn-language-server"
                },
                automatic_installation = false,
            })
        end,
    }
}
