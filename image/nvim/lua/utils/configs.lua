return {
	lsps = {
        -- bash
		"bash-language-server",
		"shellcheck",
		"shfmt",
        -- lua
		"lua-language-server",
		"stylua",
        -- python
		"python-lsp-server",
        -- webdev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"jq",
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		sh = { "shfmt" },
		json = { "jq" },
		lua = { "stylua" },
	},
	linters_by_ft = {
		bash = { "shellcheck" },
		sh = { "shellcheck" },
		json = { "jq" },
	},
	parsers = {
		"bash",
		"c",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"markdown",
		"php",
		"python",
		"rust",
		"sql",
		"toml",
		"typescript",
		"yaml",
	},
}
