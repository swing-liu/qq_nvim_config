local M = {}

local defaults = {
    author = "",
    email = "",
    max_line_width = 80,
}

local function pad_string(str, width)
    if #str > width then
        return str:sub(1, width)
    end
    return str .. string.rep(" ", width - #str)
end

local function get_create_time()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local function max_keys_length(tbl)
    local max_len = 0
    for key, _ in pairs(tbl) do
        if #key > max_len then
            max_len = #key
        end
    end
    return max_len
end

local function first_line(width)
    return "/" .. string.rep("*", width - 1)
end

local function last_line(width)
    return string.rep("*", width - 1) .. "/"
end

local function content_line(str, width)
    return pad_string(" * " .. str, width - 1) .. "*"
end

local function build_comment_block(filename, width, author, email)
    local info = {
        ["@file"] = filename,
        ["@author"] = author,
        ["@email"] = email,
        ["@date"] = get_create_time(),
    }
    local max_key_len = max_keys_length(info)

    local lines = { first_line(width) }
    for key, value in pairs(info) do
        local key_value = pad_string(key .. ": ", max_key_len + 2) .. value
        table.insert(lines, content_line(key_value, width))
    end
    table.insert(lines, last_line(width))
    table.insert(lines, "")

    return lines
end

local function build_header_guard(filename)
    local path_parts = vim.split(filename, "/")
    local name = path_parts[#path_parts]
    local parts = vim.split(name, "%.")
    local macro = "_"
    for _, p in ipairs(parts) do
        macro = macro .. p:upper() .. "_"
    end

    return {
        "#ifndef " .. macro,
        "#define " .. macro,
        "",
        "#endif" .. " /* " .. macro .. " */",
    }
end

local function is_header_file(filename)
    return filename:match("%.h$") or filename:match("%.hpp$")
end

local function insert_header(filename, buf, opts)
    local lines = build_comment_block(filename, opts.max_line_width, opts.author, opts.email)
    if is_header_file(filename) then
        vim.list_extend(lines, build_header_guard(filename))
    end
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end

local function on_new_file(opts)
    local buf = vim.api.nvim_get_current_buf()
    local filename = vim.fn.expand("%")
    insert_header(filename, buf, opts)
end

local function on_buf_enter(opts)
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local is_empty = #lines == 1 and lines[1] == ""
    if not is_empty then
        return
    end

    local filename = vim.fn.expand("%:t")
    insert_header(filename, buf, opts)
end

function M.setup(opts)
    opts = vim.tbl_deep_extend("force", defaults, opts or {})

    local group = vim.api.nvim_create_augroup("AutoCommentC", { clear = true })

    vim.api.nvim_create_autocmd("BufNewFile", {
        group = group,
        pattern = { "*.h", "*.hpp", "*.c", "*.cc", "*.cpp" },
        callback = function()
            on_new_file(opts)
        end,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        pattern = { "*.h", "*.hpp", "*.c", "*.cc", "*.cpp" },
        callback = function()
            on_buf_enter(opts)
        end,
    })
end

return M
