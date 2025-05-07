return {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" }
    },
    init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = 'yes'
    end,
    config = function()

        vim.diagnostic.config({
            virtual_text = true
        })


        -- note: diagnostics are not exclusive to lsp servers
        -- so these can be global keybindings
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_ne;xt()<cr>')


        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }


                -- these will be buffer-local keybindings
                -- because they only work if you have an active language server
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({ 'n', 'x' }, '<leader>p', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                --TODO: make this into a pop up window
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end
        })


        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()


        local default_setup = function(server)
            require('lspconfig')[server].setup({
                capabilities = lsp_capabilities,
            })
        end

        -- Setting up Mason
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'rust_analyzer', 'lua_ls' },
            handlers = {
                default_setup,
            },
        })
    end
}
