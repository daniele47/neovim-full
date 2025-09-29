local M = {}
_G.Statusline = M

function M.setup()
	-- set statusline
	vim.opt.statusline = vim.iter({
		" ",
		"%t",
		"%m%r%y",
		"%=",
		"%<%{v:lua._G.Statusline.lspList()}",
		"%=",
		"%{&ff}",
		"%l:%v",
		"%P",
		" ",
	}):join(" ")

	-- autocmd to refresh statusline when necessary
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "Refresh statusline on LspAttach",
		callback = function()
			vim.cmd("redrawstatus")
		end,
	})
	vim.api.nvim_create_autocmd("LspDetach", {
		desc = "Refresh statusline on LspDetach",
		callback = function()
			vim.defer_fn(function()
				vim.cmd("redrawstatus")
			end, 500)
		end,
	})
end

function M.lspList()
	local lsps = vim.lsp.get_clients({ bufnr = 0 })
	if #lsps > 0 then
		local lsp_icon = " "
		local lsp_names = vim.iter(lsps)
			:map(function(elem)
				return elem.name
			end)
			:join(", ")
		return lsp_icon .. lsp_names
	end
	return ""
end

M.setup()
