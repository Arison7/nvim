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
    --let's the current number get highlighted
    cursorline = true,
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
    clipboard = "unnamedplus", --Don't show the mode since lualine is already doing it showmode = false,
    --Defualt place for a split window
    splitbelow = true,
    --No swap files and better undo history
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
	--For lsp config
	signcolumn = "yes",

}


for k, v in pairs(options) do
    vim.opt[k] = v
end
