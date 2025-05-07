-- Setup for the Aura colorscheme
-- This sets the colorscheme and adjusts highlights for floating windows and the cursor line number
vim.cmd.colorscheme("aura-soft-dark")

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Character" }) -- Make the current line number bold and green


-- Setup for Alpha (start screen)
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert <cr>"),
	dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files<cr>"),
	dashboard.button("p", "  Open Project", "<cmd>Telescope projects<cr>"),
	dashboard.button("b", "  Show Keybinds (to implement)", "<cmd>WhichKey<cr>"),
	dashboard.button("c", "  Configure Neovim",
		"<cmd>e " .. vim.fn.stdpath("config") .. " | cd " .. vim.fn.stdpath("config") .. "<cr>"), dashboard
	.button("u", "  Update Plugins", "<cmd>Lazy update<cr>"),
	dashboard.button("q", "  Quit Neovim", "<cmd>wqa<cr>"),
	--{"<leader>pc",mode={"n"},require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') } )},
}
dashboard.config.opts.noautocmd = true
for _, button in ipairs(dashboard.section.buttons.val) do
	button.opts.hl = "Normal"
	button.opts.hl_shortcut = "Type"
end
dashboard.section.header.opts.hl = "Title"
--dashboard.section.buttons.opts.hl = "AlphaButtons"
--dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.opts.layout[1].val = 8

require('alpha').setup(dashboard.config)



-- Setup for Lualine (statusline)
-- This configures Lualine with a custom theme and layout
local theme = require('util.lualineAuraTheme')
require('lualine').setup {
    options = {
        theme = theme,
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
            { "diagnostics" },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { 'filename' },
        },
        lualine_x = { { 'encoding' } }, -- Same color as section B
        lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            function()
                return " " .. os.date("%R")
            end,
        },
    },
    inactive_sections = {},
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}