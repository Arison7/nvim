return {
    'simrat39/rust-tools.nvim',
    config = function()
        local rt = require("rust-tools");
        local mason_registry = require("mason-registry");
	
	--[[
        mason_registry.refresh(
            function ()
                local temp = mason_registry.get_installed_package_names()
                for k,v in pairs(temp) do
                    print( k,v )
                end
                print("hi")
                local inspect = require("vim.inspect")
                mason_registry.get_package('codelldb')
                local packages = mason_registry.get_installed_packages()
                print(inspect(packages))
                print(#packages)
                for k,v in pairs(packages) do
                    print( k,v )
                end
            end
        )
	]]--
        --local codelldb = mason_registry.get_package("codelldb");
        --local extension_path  = codelldb.get_install_path() .. "/extension/";
        --local codelldb_path = extension_path .. "adapter/codelldb"
        --local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"


        rt.setup({
            dap = {
                --adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path,liblldb_path);
            },
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>rt", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
            tools = {
                hover_actions = {
                    auto_focus = true,
                }
            }


        }
        )
    end

}
