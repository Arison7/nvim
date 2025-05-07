-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugin list
    {
        "baliestri/aura-theme",
        lazy = false,
        priority = 1000,
        --TODO: figure what plugin stands for to take it out of here
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        end
    },
    "nvim-lua/plenary.nvim",
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Ui plugins
    'goolord/alpha-nvim',
    'echasnovski/mini.icons',
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        --TODO: Figure out when init should run and put it somewhere else
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page

                vim.o.laststatus = 0
            end
        end
    },


        { 'echasnovski/mini.pairs',              version = '*' },
        { 'ThePrimeagen/harpoon',                branch = 'harpoon2', dependencies = { 'nvim-lua/plenary.nvim' } },
        { 'lukas-reineke/indent-blankline.nvim', main = 'ibl',        opts = {} },
        { 'echasnovski/mini.indentscope',        version = '*' },
        {
            'neovim/nvim-lspconfig',
            cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "L3MON4D3/LuaSnip" }
            },
        },
        { 'akinsho/toggleterm.nvim',       version = '*' },
        { 'folke/todo-comments.nvim',      dependencies = { 'nvim-lua/plenary.nvim' } },
        { 'nvim-telescope/telescope.nvim', branch = '0.1.x',                          dependencies = { 'nvim-lua/plenary.nvim' } },
        { 'simrat39/rust-tools.nvim' },
        { 'mrcjkb/rustaceanvim',           version = '^5',                            lazy = false },
        { 'nvim-tree/nvim-tree.lua',       version = '*',                             dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'mfussenegger/nvim-dap' },
        { 'rcarriga/nvim-dap-ui',          dependencies = { 'nvim-neotest/nvim-nio' } },
        'theHamsta/nvim-dap-virtual-text',
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp-signature-help",
            }
        },
        { 'folke/noice.nvim',  event = 'VeryLazy', dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' } },
        { 'camspiers/luarocks' },
        { 'tpope/vim-fugitive',  cmd = { 'Git' } },
        { 'jiaoshijie/undotree', dependencies = 'nvim-lua/plenary.nvim' },
})
