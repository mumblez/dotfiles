local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local function file_exists(name)
    local f=io.open(name, "r")
    if f~=nil then io.close(f) return true else return false end
end


-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

    -- if server.name == "jsonls" then
    --     local jsonls_opts = require("user.lsp.settings.jsonls")
    --     opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    -- end
    --
    -- if server.name == "sumneko_lua" then
    --     local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    --     opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- end
    --
    -- if server.name == "terraformls" then
    --     local terraformls_opts = require("user.lsp.settings.terraformls")
    --     opts = vim.tbl_deep_extend("force", terraformls_opts, opts)
    -- end

    -- if vim.fn.empty(vim.fn.glob(settings_file)) == 0 then
    -- cleaner if we can get current working directory!
    local settings_file = vim.fn.stdpath("config") .. "/lua/user/lsp/settings/" .. server.name .. ".lua"
    if file_exists(settings_file) then
        local local_opts = require("user.lsp.settings." .. server.name)
        opts = vim.tbl_deep_extend("force", local_opts, opts)
    end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

