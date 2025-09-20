return {
	"stevearc/conform.nvim",
	keys = {
		{
			"grf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
		},
	},
	cmd = "ConformInfo",
	opts = {
		notify_on_error = false,
		notify_no_formatters = false,
		format_on_save = false,
		formatters_by_ft = require("utils.configs").formatters_by_ft,
	},
}

