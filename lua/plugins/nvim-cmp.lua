return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			sources = {
				{ name = 'nvim_lsp' },
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
	end






}
