-- additional keymaps for buffers with lsp attached
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Create keymaps for buffers with lsp attached",
	callback = function(event)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
	end,
})

-- configure diagnostics
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = true,
	float = { border = "single" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

-- configure lsp floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 100
	opts.max_height = opts.max_height or 15
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- auto command to install parsers and lsps
vim.api.nvim_create_user_command("StarterPack", function()
	-- download parsers
	local res = require("nvim-treesitter").install(require("utils.configs").parsers)
	if #vim.api.nvim_list_uis() == 0 then
		res:wait(300000)
	end
	-- download lsps
	local mason_registry = require("mason-registry")
	local configs = require("utils.configs")
	local to_install_lsps = configs.lsps
	local installed_lsps = mason_registry.get_installed_package_names()
	local missing_lsps = vim.iter(to_install_lsps)
		:filter(function(elem)
			return not vim.tbl_contains(installed_lsps, elem)
		end)
		:join(" ")
	if missing_lsps ~= "" then
		vim.cmd("MasonInstall " .. missing_lsps)
	end
end, {})
