return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		local function parse()
			vim.schedule(function()
				pcall(vim.treesitter.start)
			end)
		end
		vim.api.nvim_create_autocmd("Filetype", {
			desc = "Start treesitter parser",
			callback = parse,
		})
		parse()
	end,
}
