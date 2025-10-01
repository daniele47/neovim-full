-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.mousemodel = "extend"
vim.opt.pumheight = 15
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.cmd.colorscheme("ultimate")

-- use clipboard-osc52 to be able to copy from inside a container
vim.g.clipboard = {
	name = "OSC52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = function() end,
		["*"] = function() end,
	},
}

-- keymaps
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- create autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.hl.on_yank()
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Disable autocommenting",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- install plugins using lazy
require("lazy").setup({
	{ import = "plugins" },
}, {
	change_detection = {
		enabled = false,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tohtml",
				"tutor",
				"zipPlugin",
				"tarPlugin",
				-- "osc52",
				"shada",
				"spellfile",
				"man",
				"editorconfig",
				-- "netrwPlugin",
				"rplugin",
				-- "matchit",
				"matchparen",
			},
		},
	},
})

-- shaky support for builtin snippet engine (to remember how it's done!)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
    end,
})
vim.keymap.set({"i", "s"}, "<C-l>", function()
    if vim.fn.pumvisible() == 1 then
        -- If completion menu is open, select next item
        return "<C-n>"
    else
        -- Otherwise, jump to next snippet placeholder
        return vim.snippet.jump(1)
    end
end, {expr = true})

vim.keymap.set({"i", "s"}, "<C-h>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    else
        return vim.snippet.jump(-1)
    end
end, {expr = true})
vim.keymap.set({"i", "s"}, "<C-k>", function()
    vim.snippet.stop()
    return ""
end, {expr = true})

