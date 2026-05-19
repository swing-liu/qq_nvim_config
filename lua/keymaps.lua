-- ~/.config/nvim/lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- ===== Ctrl+S 保存 =====
map("i", "<C-S>", "<Esc>:w!<CR>", opts)
map("v", "<C-S>", "<Esc>:w!<CR>", opts)
map("n", "<C-S>", ":w!<CR>", opts)

-- ===== Ctrl+T 打开终端 =====
map("n", "<C-t>", ":rightbelow terminal<CR>", opts)
map("t", "<C-t>", "<C-\\><C-n>:rightbelow terminal<CR>", opts) -- 终端模式下也能开新终端

-- ===== 窗口导航 =====
map("n", "<leader>a", "<C-w>h", opts)
map("n", "<leader>d", "<C-w>l", opts)
map("n", "<leader>s", "<C-w>j", opts)
map("n", "<leader>w", "<C-w>k", opts)
map("n", "<leader><Tab>", "<C-w>w", opts)

-- ===== 窗口大小调整 =====
map("n", "<leader>,", "<C-w>>10", opts)
map("n", "<leader>.", "<C-w><10", opts)
map("n", "<leader>-", "<C-w>-5", opts)
map("n", "<leader>=", "<C-w>+5", opts)

-- ===== 缓冲区操作 =====
map("n", "<leader>n", ":bn<CR>", opts)
map("n", "<leader>c", ":b #<CR>:bd #<CR>", opts) -- 返回上一个缓冲区并删除当前
map("n", "<leader>q", ":qa<CR>", opts)

-- ===== 粘贴系统剪贴板 =====
map("n", "<leader>p", '"+gp', opts)

-- ===== 可视模式注释 =====
-- map("v", "<leader>c", "I//<Esc>", opts)

-- ===== 可视模式缩进 =====
-- map("v", "<leader><Tab>", "I<Tab><Esc>", opts)

-- ===== 插入模式括号配对 =====
map("i", "{", "{}<Left>", { noremap = true }) -- silent 不需要，因为要看到输入
