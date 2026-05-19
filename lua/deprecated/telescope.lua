-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  tag = "0.1.8", -- 使用稳定版本
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- 可选但强烈推荐，提高排序质量
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    defaults = {
      -- 默认配置，之后可以在这里自定义
      layout_strategy = "horizontal",                   -- 水平布局
      layout_config = { height = 0.8, width = 0.8 },    -- 占屏幕80%
      sorting_strategy = "ascending",                   -- 结果从上到下排列
      border = true,                                    -- 显示边框
      path_display = { "truncate" }                     -- 长路径截断
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",   desc = "查找文件" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",    desc = "全文搜索" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "查找缓冲区" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "查找帮助" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",     desc = "最近文件" },
    -- 下面是与lsp联动的键位
    -- { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",  desc = "文件符号" },
    -- { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "工作区符号" },
    -- { "<leader>fd", "<cmd>Telescope diagnostics<cr>",           desc = "诊断信息" },
    -- { "<leader>fc", "<cmd>Telescope grep_string<cr>",           desc = "搜索光标下单词" },
  },
}

