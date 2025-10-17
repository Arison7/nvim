-- Nvim-Tree Configuration
-- This section sets up the file explorer with floating window support
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>pv", function() require("nvim-tree.api").tree.toggle() end,{desc="Toggle nvim tree float"})

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
        number = true,
        relativenumber = true,
        float = {
            enable = true,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                local window_w = screen_w * WIDTH_RATIO
                local window_h = screen_h * HEIGHT_RATIO
                local window_w_int = math.floor(window_w)
                local window_h_int = math.floor(window_h)
                local center_x = (screen_w - window_w) / 2
                local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                return {
                    border = "rounded",
                    relative = "editor",
                    row = center_y,
                    col = center_x,
                    width = window_w_int,
                    height = window_h_int,
                }
            end,
        },
    },
})

local api = require("nvim-tree.api")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function()
		vim.keymap.set("n", "?", api.tree.toggle_help, { buffer = true, desc = "Toggle NvimTree Help" })
	end,
})


-- Telescope Configuration
-- This section sets up fuzzy finding and searching
vim.keymap.set("n", "<leader>pf", require('telescope.builtin').find_files, {desc= "Fuzzy finder file search"})
vim.keymap.set("n", "<C-p>", require('telescope.builtin').git_files,{desc= "Fuzzy finder file search(git)"})
vim.keymap.set("n", "<leader>pg", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
end, {desc="Grep on functionality"})

require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git",
        },
    },
}

-- Harpoon Configuration
local conf = require("telescope.config").values
-- Harpoon with telescope
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
local harpoon = require("harpoon")

harpoon:setup({})


vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to Harpoon" })
vim.keymap.set("n", "<C-g>", function() toggle_telescope(harpoon:list()) end, { desc = "Open Harpoon window" })
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "Select Harpoon item 1" })
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "Select Harpoon item 2" })
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "Select Harpoon item 3" })

-- This may not work as expected because "<C-;>" isn't reliably mappable in all terminals
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end, { desc = "Select Harpoon item 4" })

-- Alternative mappings for previous/next items
vim.keymap.set("n", "<C-g-;>", function() harpoon:list():prev() end, { desc = "Go to previous Harpoon item" })
vim.keymap.set("n", "<C-g-,>", function() harpoon:list():next() end, { desc = "Go to next Harpoon item" })
