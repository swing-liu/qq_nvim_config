-- ~/.config/nvim/lua/config/lsp-info.lua
-- Custom :LspStatus command to inspect LSP servers for the current buffer

local function lsp_status()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        vim.notify("No LSP servers attached to current buffer", vim.log.levels.WARN)
        return
    end
    -- Build floating window content
    local lines = {}
    local buf_name = vim.fn.expand("%:t")
    local ft = vim.bo.filetype
    table.insert(lines, "  LSP Status — " .. buf_name .. "  [ft=" .. ft .. "]")
    table.insert(lines, string.rep("─", 55))
    for _, client in ipairs(clients) do
        -- Server name + ID
        table.insert(lines, "  ● " .. client.name .. "  (id: " .. client.id .. ")")
        -- Root directory
        local root = client.root_dir or client.config.root_dir or "(no root detected)"
        table.insert(lines, "    Root:     " .. root)
        -- Executable command
        local cmd = client.config.cmd
        if type(cmd) == "table" then
            table.insert(lines, "    Cmd:      " .. table.concat(cmd, " "))
        end
        -- Supported capabilities
        local caps = {}
        local c = client.server_capabilities or {}
        if c.hoverProvider then table.insert(caps, "Hover") end
        if c.definitionProvider then table.insert(caps, "Definition") end
        if c.declarationProvider then table.insert(caps, "Declaration") end
        if c.referencesProvider then table.insert(caps, "References") end
        if c.renameProvider then table.insert(caps, "Rename") end
        if c.codeActionProvider then table.insert(caps, "CodeAction") end
        if c.completionProvider then table.insert(caps, "Completion") end
        if c.documentFormattingProvider then table.insert(caps, "Format") end
        if c.inlayHintProvider then table.insert(caps, "InlayHint") end
        if #caps > 0 then
            table.insert(lines, "    Caps:     " .. table.concat(caps, " · "))
        end
        table.insert(lines, string.rep("─", 55))
    end
    table.insert(lines, "  " .. #clients .. " server(s) running")
    table.insert(lines, "")
    -- Calculate floating window size
    local width = 0
    for _, line in ipairs(lines) do
        width = math.max(width, vim.fn.strdisplaywidth(line) + 2)
    end
    local height = #lines
    -- Create buffer
    local float_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
    vim.bo[float_buf].modifiable = false
    vim.bo[float_buf].filetype = "lspinfo"
    -- Apply highlights
    local ns = vim.api.nvim_create_namespace("lsp_status")
    vim.api.nvim_buf_add_highlight(float_buf, ns, "Title", 0, 0, -1)
    vim.api.nvim_buf_add_highlight(float_buf, ns, "Comment", 1, 0, -1)
    for i, line in ipairs(lines) do
        if line:match("^  ●") then
            vim.api.nvim_buf_add_highlight(float_buf, ns, "Function", i - 1, 0, -1)
        end
        if line:match("^    Root") then
            vim.api.nvim_buf_add_highlight(float_buf, ns, "Directory", i - 1, 0, -1)
        end
        if line:match("^    Caps") then
            vim.api.nvim_buf_add_highlight(float_buf, ns, "String", i - 1, 0, -1)
        end
        if line:match("^─+$") or line:match("^  %d") then
            vim.api.nvim_buf_add_highlight(float_buf, ns, "Comment", i - 1, 0, -1)
        end
    end
    -- Open centered floating window
    local ui = vim.api.nvim_list_uis()[1]
    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((ui.width - width) / 2),
        row = math.floor((ui.height - height) / 2),
        style = "minimal",
        border = "rounded",
        title = " LSP Info ",
        title_pos = "center",
    }
    local float_win = vim.api.nvim_open_win(float_buf, true, win_opts)
    vim.wo[float_win].winhl = "Normal:NormalFloat,FloatBorder:FloatBorder"
    -- Close with q / Esc / Enter
    for _, key in ipairs({ "q", "<Esc>", "<CR>" }) do
        vim.keymap.set("n", key, function()
            vim.api.nvim_win_close(float_win, true)
        end, { buffer = float_buf, silent = true, nowait = true })
    end
end

-- Register command
vim.api.nvim_create_user_command("LspStatus", lsp_status, {
    desc = "Show LSP server info for current buffer",
})
