-- Brackets Configuration
-- This section configures matching brackets and highlights them
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MatchParen", { link = "Character" })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Character" })
	end,
})

require("mini.pairs").setup()

-- Indentation Configuration
-- This section configures indentation guides and scope highlighting
require("ibl").setup({
	indent = { char = "│" },
})


require('mini.indentscope').setup({
	symbol = "▏", -- Use this character instead of │
	options = { try_as_border = true },
	-- Removing files where indent-blankline is also removed
	draw = {
		delay = 0,
		predicate = function()
			local exclude_filetypes = {
				"help", "alpha", "dashboard", "neo-tree", "Trouble",
				"lazy", "mason", "notify", "toggleterm", "lazyterm", "NvimTree"
			}
			return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype);
		end

	}
}
);



-- TODO Comments Configuration
-- This section highlights and manages TODO comments in your code
require("todo-comments").setup({
	signs = true, -- Show icons in the sign column
	keywords = {
		TODO = { icon = " ", color = "info" },
		FIX = { icon = " ", color = "error" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning" },
		PERF = { icon = " ", color = "hint" },
		NOTE = { icon = " ", color = "hint" },
	},
})
