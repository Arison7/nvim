
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- remove from the dashboard
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- set an empty statusline till lualine loads
            vim.o.statusline = " "
       else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    --TODO: change the visuals
    config = function()
        local theme = require('util.lualineAuraTheme')
        require('lualine').setup {
             options = {
                theme = theme;
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
                    { "diagnostics"  },
                    { "filetype",    icon_only = true,          separator = "", padding = { left = 1, right = 0 } },
                    { 'filename'    },
                },
                lualine_x = { {'encoding'}}, -- Same color as section B
                lualine_y = {
                    { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
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
    end
}
