-- ~/.config/nvim/lua/options.lua

vim.opt.termguicolors = true -- 启用真彩色
vim.opt.background = "dark"  -- 深色背景
vim.o.winborder = "rounded"  -- 窗口边框
vim.o.mouse = ""
vim.opt.timeoutlen = 500

-- 设置 leader 键为逗号
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- 退格可以任意删除
vim.opt.backspace = "2"

-- 允许 h、l 在行首行尾换行
vim.opt.whichwrap:append("h,l")

-- 命令模式自动补全
vim.opt.wildmode = "longest:full,full"

-- 显示行号
vim.opt.number = true

-- 中文编码支持
vim.opt.fileencodings = "utf-8,gb2312,gbk,cp936"
vim.opt.encoding = "utf-8"

-- Tab 替换为 4 个空格
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- 自动缩进
vim.opt.autoindent = true

-- 突出显示当前行
vim.opt.cursorline = true

-- hover触发时长ms
vim.o.updatetime = 2000

vim.cmd("autocmd CursorHold * lua vim.lsp.buf.document_highlight()")
vim.cmd("autocmd CursorMoved * lua vim.lsp.buf.clear_references()")

-- 搜索时只更改字体颜色，背景跟随系统
-- vim.cmd("highlight Search ctermfg=0 ctermbg=227 guifg=#000000 guibg=NONE gui=bold")
-- vim.cmd("highlight IncSearch ctermfg=0 ctermbg=227 guifg=#000000 guibg=NONE gui=bold")

-- 搜索高亮：黄字、加粗、背景跟随系统
-- vim.cmd("highlight Search guifg=#FFD75F guibg=NONE gui=bold")
-- vim.cmd("highlight IncSearch guifg=#FFD75F guibg=NONE gui=bold")

-- 备份设置
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/Documents/vim_backup//" -- 注意结尾双斜杠
vim.opt.swapfile = false

-- 匹配尖括号
vim.opt.matchpairs:append("<:>")

-- 共享系统剪贴板
-- vim.opt.clipboard = "unnamedplus"

-- 按 Esc 清除搜索高亮
vim.keymap.set("n", "<Esc>", function()
    vim.cmd("nohlsearch")
    -- 保留 Esc 原有功能：关闭命令行等
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
end, { desc = "清除搜索高亮" })

-- 将类型标签颜色改为灰色
-- vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#808080', italic = true })

-- 修改补全占位文本颜色
-- vim.api.nvim_set_hl(0, 'CmpGhostText', { fg = '#808080', italic = true })

-- 打开终端时自动进入插入模式
vim.cmd("autocmd TermOpen * startinsert")

-- 清除lsp注册的CursorHold事件
vim.api.nvim_clear_autocmds({
    event = { "CursorHold", "CursorHoldI" },
})
