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


return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
	  { "<leader>a", mode = { "n" }, function() require("harpoon"):list():add() end, desc = "Add file to Harpoon" },
	  { "<C-g>", mode = { "n" }, function() toggle_telescope(require("harpoon"):list()) end, desc = "Open Harpoon window" },
	  { "<C-j>", mode = { "n" }, function() require("harpoon"):list():select(1) end, desc = "Select Harpoon item 1" },
	  { "<C-k>", mode = { "n" }, function() require("harpoon"):list():select(2) end, desc = "Select Harpoon item 2" },
	  { "<C-l>", mode = { "n" }, function() require("harpoon"):list():select(3) end, desc = "Select Harpoon item 3" },
	  { "<C-;>", mode = { "n" }, function() require("harpoon"):list():select(4) end, desc = "Select Harpoon item 4" },
	  { "<C-g-;>", mode = { "n" }, function() require("harpoon"):list():prev() end, desc = "Go to previous Harpoon item" },
	  { "<C-g-,>", mode = { "n" }, function() require("harpoon"):list():next() end, desc = "Go to next Harpoon item" },
	},
	dependencies = { "nvim-lua/plenary.nvim" }
}
