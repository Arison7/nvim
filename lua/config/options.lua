local options = {
	--indentation
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	expandtab = true,
	smartindent = true,
	--numbers
	number = true,
	relativenumber = true,
	--search
	hlsearch = false,
	incsearch = true,
	--colors
	termguicolors = true,
	--scrolling
	scrolloff = 8,
	--update time
	updatetime = 50,
    --Choose the default clipboard
    clipboard = "unnamedplus",
    --Don't show the mode since lualine is already doing it
    showmode = false,

}

for k, v in pairs(options) do
	vim.opt[k] = v
end
