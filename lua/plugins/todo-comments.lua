-- ~/.config/nvim/lua/plugins/todo-comments.lua
return {
    "folke/todo-comments.nvim",
    enable = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- 你的个性化配置会放在这里，暂时可以为空
        -- keywords = {
        --   HACK = { icon = "🐛", color = "warning" },
        -- }
    },
}
