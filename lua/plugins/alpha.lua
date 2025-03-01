return {
    'goolord/alpha-nvim',
    dependencies = {
        'echasnovski/mini.icons',
        'nvim-lua/plenary.nvim'
    },
    -- Configure the dashboard in options
    opts = function()
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


        return dashboard;
    end,
    -- Gets the dashboard from opts functions
    config = function(_, dashboard)
        -- Show the dashboard
        require('alpha').setup(dashboard.config)
    end
};
