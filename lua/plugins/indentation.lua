return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},

        config = function()
            require("ibl").setup {
                indent = { char = "▏" }
            }
        end
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        config = function()
            require('mini.indentscope').setup({
                symbol = "▏", -- Use this character instead of │
                options = { try_as_border = true },
                -- Removing files where indent-blankline is also removed
                draw = {
                    delay = 0,
                    predicate = function()
                        local exclude_filetypes = {
                            "help", "alpha", "dashboard", "neo-tree", "Trouble",
                            "lazy", "mason", "notify", "toggleterm", "lazyterm","NvimTree"
                        }
                        return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype);
                    end

                }
            }
            );
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Character" })
        end
    }
}
