local wk = require("which-key")

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

	-- Split
	{ "<leader>|", "<cmd>vs<CR>", desc = "Split vertical" },
	{ "<leader>-", "<cmd>sp<CR>", desc = "Split horizontal" },
})
