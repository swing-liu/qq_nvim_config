-- ~/.config/nvim/lua/plugins/nvim-tree.lua

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    enabled = true,
    config = function()
        require("nvim-tree").setup({
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                local opts = function(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
                end

                -- 先加载默认键位
                api.config.mappings.default_on_attach(bufnr)

                -- 覆盖 Enter：跳到上一个窗口再打开文件
                vim.keymap.set("n", "<CR>", function()
                    local node = api.tree.get_node_under_cursor()
                    if node and node.type == "file" then
                        local filepath = node.absolute_path

                        -- 检查文件是否已经在某个窗口中打开
                        local target_win = nil
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            local buf_name = vim.api.nvim_buf_get_name(buf)
                            if buf_name == filepath then
                                target_win = win
                                break
                            end
                        end

                        if target_win then
                            -- 文件已存在于某个分屏，直接跳过去
                            vim.api.nvim_set_current_win(target_win)
                        else
                            vim.cmd("wincmd p")
                            -- 如果跳回的窗口还是 nvim-tree，就改用竖直分屏打开
                            if require("nvim-tree.view").is_visible() and vim.api.nvim_get_current_win() == require("nvim-tree.view").get_winnr() then
                                vim.cmd("vsplit " .. vim.fn.fnameescape(filepath))
                            else
                                vim.cmd("edit " .. vim.fn.fnameescape(filepath))
                            end
                        end
                    else
                        api.node.open.edit()
                    end
                end, opts("Open: stay in last window"))
            end,
            -- 保持根目录同步
            sync_root_with_cwd = true,
            -- 外观设置
            view = {
                width = 30,
                side = "left",
                preserve_window_proportions = true,
            },

            -- 文件过滤
            filters = {
                dotfiles = false, -- 显示 . 开头的文件
                custom = { ".git", "__pycache__", "node_modules", ".cache" },
            },

            -- 渲染选项
            renderer = {
                group_empty = true,
                highlight_git = "icon",
                highlight_opened_files = "all",
                root_folder_label = "~/",
                indent_markers = {
                    enable = true,
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },

            -- Git 集成
            git = {
                enable = true,
                ignore = false,
                timeout = 500,
            },

            -- 文件操作
            actions = {
                change_dir = {
                    enable = true,
                    -- true = :cd (全局生效), false = :lcd (仅当前窗口)
                    global = true,
                },
                open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                        enable = false,
                    },
                },
            },

            -- 系统剪贴板（新版中使用 vim.ui 代替）
            -- clipboard 选项已移除，使用系统剪贴板需要额外配置

            -- 更新文件系统事件
            update_focused_file = {
                enable = false,    -- 自动更新焦点文件的树节点
                update_cwd = true, -- 切换目录时更新根目录
            },

            -- 日志（调试用，平时可以关闭）
            diagnostics = {
                enable = false,
            },
        })

        -- 设置快捷键
        local map = vim.keymap.set
        map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
        -- map("n", "<C-f>", ":NvimTreeFindFile<CR>", { desc = "Find current file" })
        -- map("n", "<C-R>", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })
    end,
}
