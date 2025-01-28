print("test");

local options = {
	tabstop = 4,
	shiftwidth = 4,
	number = true,
	relativenumber = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
