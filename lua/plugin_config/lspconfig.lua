-- LSP Configuration

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  severity_sort = true,
})

-- Diagnostics keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }
		-- Buffer-local keybindings for LSP
		vim.keymap.set('n', 'ld', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'li', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'lR', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', 'lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<leader>lp', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
		vim.keymap.set('n', 'la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
    -- Let's Rustacenvim set it up
    if server == "rust_analyzer" then
        return
    end
	require('lspconfig')[server].setup({
		capabilities = lsp_capabilities,
	})
end

-- Setting up Mason
require('mason').setup({})

require('mason-nvim-dap').setup({
    ensure_installed = {"codelldb"}
})
require('mason-lspconfig').setup({
	ensure_installed = { 'rust_analyzer', 'lua_ls'},
	handlers = {
		default_setup,
	},
})

-- nvim-cmp Configuration
-- This section sets up autocompletion
local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	window = {
		completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {
			"i",
			"s"
		}),
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

