return {
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    {
        "baliestri/aura-theme",
        lazy = false,
        priority = 1000,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
            vim.cmd.colorscheme("aura-soft-dark")

            vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
            vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

            -- make the current line number bold and green
            vim.api.nvim_set_hl(0, "CursorLineNr", { link="Character" })
        end
    }
}
