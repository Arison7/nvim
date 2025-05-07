-- Rust Tools Configuration
-- This section sets up Rust-specific tools for development
--[[
local rt = require("rust-tools")

rt.setup({
    dap = {
        -- adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>rt", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    tools = {
        hover_actions = {
            auto_focus = true,
        },
    },
})

]]

-- RustaceanVim Configuration
-- This section sets up RustaceanVim for additional Rust-related features
vim.g.rustacean_color = "dark" -- Set the color scheme for RustaceanVim