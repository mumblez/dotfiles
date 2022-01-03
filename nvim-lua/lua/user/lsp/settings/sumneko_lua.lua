return {
	settings = {

        cmd = { vim.env.HOME .. '/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server'},
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
