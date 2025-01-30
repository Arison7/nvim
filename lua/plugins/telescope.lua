

return {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys={
		{"<leader>pf",mode={"n"},require('telescope.builtin').find_files},
		{"<C-p>",mode={"n"},require('telescope.builtin').get_files},
		{"<leader>ps",mode={"n"}, function()
			builtin.grep_string(
				{ search = vim.fn.input("Grep > ")}
			)
		
		end
		},

	},
	-- doesn't seem to work
	config = function()
		require("telescope").setup{
			defualts = {
				file_ignore_patterns = {
					"node_modules",
					".git"
				}
			}
		}
	end


    }
