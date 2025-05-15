local wk = require("which-key");


wk.setup({
    triggers = { "<auto>", mode = "nixsotc" },

})

wk.add({
    {'<Leader>g',group="diagnostic"},
    {'<Leader>d',group="debug"},
    {'<Leader>l',group="lsp"},
    {'<Leader>p',group="pathing"},
    {'<Leader>h',group="harpoon"},


})

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', '<Leader>dd', '<cmd>lua require("telescope.builtin").diagnostics()<cr>')





