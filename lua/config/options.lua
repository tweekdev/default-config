vim.g.lazyvim_eslint_auto_format = true
vim.g.lazyvim_prettier_needs_config = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.wo.number = true
local opt = vim.opt -- for conciseness

vim.opt.clipboard = "unnamedplus" -- use system keyboard for yank
vim.cmd("let g:netrw_liststyle = 3")

vim.opt.nu = true -- set line numbers -- set line numbers
vim.opt.relativenumber = true -- use relative line numbers

vim.opt.wrap = true

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

local default_diagnostic_config = {
	signs = true,
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(diagnostic)
			return string.format("%s (%s)", diagnostic.message, diagnostic.source)
		end,
	},
}

vim.diagnostic.config(default_diagnostic_config)
