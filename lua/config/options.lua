--vim.g.lazyvim_eslint_auto_format = true
vim.g.lazyvim_prettier_needs_config = false

--vim.o.winborder = "solid"
if vim.bo.modifiable then
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true
end

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--vim.opt.colorcolumn = "100"

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
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
--opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

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
