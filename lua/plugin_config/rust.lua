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
--
--
--[[
local mason_registry = require('mason-registry')
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb.get_package_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path.. "lldb/lib/liblldb.dylib"
local cfg = require('rustaceanvim.config')
]]--
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = mason_path .. "adapter/codelldb"
local liblldb_path = mason_path .. "lldb/lib/liblldb.so"

vim.g.rustaceanvim = {
  dap = {
    adapter = require("rustaceanvim.config").get_codelldb_adapter(
      codelldb_path,
      liblldb_path
    ),
  },
}



vim.g.rustacean_color = "dark" -- Set the color scheme for RustaceanVim
