return {
 
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
},
keys = {
  { "<leader>pv", function() require("nvim-tree.api").tree.open() end, mode = "n" }
}
--  keys={{"<leader>pv",{"n"},require('nvim-tree.api').tree.open}},
  config = function()
    require("nvim-tree").setup {}
  end,
}
