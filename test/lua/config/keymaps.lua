local wk = require("which-key")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Move to window using the <ctrl> hjkl keys
vim.g.mapleader = " "

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- split window
vim.keymap.set("n", "<leader>|", vim.cmd.vs)
vim.keymap.set("n", "<leader>-", vim.cmd.sp)

-- Telescope
vim.keymap.set("n", "<C-p>", builtin.find_files, {})

-- Neo-tree
--vim.keymap.set("n", "<C-b>", "<cmd>Neotree filesystem reveal left<CR>", {})
vim.keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>")

-- Which-key labels and keymaps
wk.add({
	-- No groups
	{ "<leader>a", hidden = true },
	{ "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "LSP hover" },
	{ "<leader>w", "<cmd>wall!<CR>", desc = "Save all files" },
	{ "<leader>Q", "<cmd>wqall!<CR>", desc = "Save and Quit" },
	{ "<leader>b", "<cmd>BufferLinePick<CR>", desc = "Buffer switcher" },

	-- Code
	{ "<leader>c", group = "+code" },
	{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
	{ "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format" },
	{ "<leader>cr", ":IncRename ", desc = "Rename" },
	{ "c", group = "+code" },
	{ "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
	{ "cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format" },
	{ "cr", ":IncRename ", desc = "Rename" },

	-- Debugger
	{ "<leader>d", group = "+debugger" },
	{ "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
	{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
	{ "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Terminate" },
	{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step Over" },

	-- Find
	{ "<leader>f", group = "+find" },
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Live Grep" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", desc = "Buffers" },
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "Help Tags" },

	-- Goto
	{ "<leader>g", group = "+goto" },
	{ "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
	{ "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
	{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition" },
	{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
	{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
	{ "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
	{ "g", group = "+goto" },
	{ "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
	{ "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition" },
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
	{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
	{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },

	-- LSP
	{ "<leader>l", group = "+lsp" },
	{ "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format" },
	{ "<leader>lr", ":IncRename ", desc = "Rename" },

	-- Trouble
	{ "<leader>x", group = "+trouble" },
	{ "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Toggle" },
	{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
	{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
	{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix" },
	{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Loclist" },
})
