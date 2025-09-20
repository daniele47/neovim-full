return {
	on_init = function(client)
		if client.workspace_folders then
			local path = vim.fn.resolve(client.workspace_folders[1].name)
			local conf = vim.fn.resolve(vim.fn.stdpath("config"))
			if path == conf then
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							-- "${3rd}/busted/library",
						},
					},
				})
			end
		end
	end,
	settings = {
		Lua = {
			completion = {
				autoRequire = false,
			},
			hint = {
				enable = true,
			},
		},
	},
}
