return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function() 
        require('toggleterm').setup {
            open_mapping = "<c-\\>",
            direction = "float",
            float_opts = {
                border = "rounded"
            },
            shell = vim.fn.executable("zsh") == 1 and "zsh" or vim.o.shell,
            shellcmdflag = "--rcfile ~/.config/.zshrc-no-neocat -i",
        }
    end
};


