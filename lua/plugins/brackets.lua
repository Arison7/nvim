
-- color matching brackets 
-- TODO: Consider a more unique color for this 
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "MatchParen", {link = "Character" })
    end
})



return { {
    --BUG: this doesn't work
    -- Automatically create a pair of brackets and qoutes
    'echasnovski/mini.pairs',
    version = '*',
}}


