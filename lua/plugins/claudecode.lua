return {
    {
        'coder/claudecode.nvim',
        dependencies = {
            -- 'folke/snacks.nvim',
        },
        enabled = true,
        config = true,
        -- cmd = { 'ClaudeCode', 'ClaudeCodeFocus', 'ClaudeCodeStart', 'ClaudeCodeStop', 'ClaudeCodeStatus', 'ClaudeCodeSend', 'ClaudeCodeAdd', 'ClaudeCodeSelectModel', 'ClaudeCodeDiffAccept', 'ClaudeCodeDiffDeny', 'ClaudeCodeTreeAdd', 'ClaudeCodeClose', 'ClaudeCodeOpen' },
        opts = {
            terminal = {
                enabled = true,
                snacks_win_opts = {
                    wo = {
                        winblend = 100,
                        winhighlight = 'NormalFloat:MyTransparentGroup',
                    },
                },
            },
        },
        keys = {
            -- { '<leader>i', nil, desc = 'Claude Code' },
            { '<leader>ic', '<cmd>ClaudeCode<cr>',            desc = 'Toggle Claude' },
            { '<leader>if', '<cmd>ClaudeCodeFocus<cr>',       desc = 'Focus Claude' },
            { '<leader>ir', '<cmd>ClaudeCode --resume<cr>',   desc = 'Resume Claude' },
            { '<leader>iC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
            { '<leader>im', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
            { '<leader>ib', '<cmd>ClaudeCodeAdd %<cr>',       desc = 'Add current buffer' },
            { '<leader>is', '<cmd>ClaudeCodeSend<cr>',        mode = 'v',                  desc = 'Send to Claude' },
            {
                '<leader>is',
                '<cmd>ClaudeCodeTreeAdd<cr>',
                desc = 'Add file',
                ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
            },
            { '<leader>ia', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
            { '<leader>id', '<cmd>ClaudeCodeDiffDeny<cr>',   desc = 'Deny diff' },
        },
    },
    {
        'gutsavgupta/nvim-gemini-companion',
        enabled = false,
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = 'VeryLazy',
        config = function()
            require('gemini').setup()
        end,
        keys = {
            { '<leader>g',   nil,                                 desc = 'Gemini Code' },
            { '<leader>gg',  '<cmd>GeminiToggle<cr>',             desc = 'Toggle Gemini sidebar' },
            { '<leader>gc',  '<cmd>GeminiSwitchToCli<cr>',        desc = 'Spawn or switch to AI session' },
            { '<leader>gdl', '<cmd>GeminiSendLineDiagnostic<cr>', mode = 'n',                            desc = 'Send to Gemini' },
            { '<leader>gD',  '<cmd>GeminiSendFileDiagnostic<cr>', mode = 'n',                            desc = 'Send to Gemini' },
            { '<leader>ga',  '<cmd>GeminiAccept<cr>',             mode = 'n',                            desc = 'Accept Gemini Diff' },
            { '<leader>gdd', '<cmd>GeminiDeny<cr>',               mode = 'n',                            desc = 'Deny Gemini Diff' },
            { '<leader>gs',  '<cmd>GeminiSend<cr>',               mode = { 'v' },                        desc = 'Send selection to Gemini' },
        },
    },
}
