local wk = require("which-key")
local opts = { noremap = true, silent = true }

-- Leader key configuration
vim.g.mapleader = " "

-- Basic keymaps
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlighting" })
vim.keymap.set("n", "<leader>w", "<cmd>wall!<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>Q", "<cmd>wqall!<CR>", { desc = "Save and quit all" })
vim.keymap.set("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Buffer switcher" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Window management
-- Split windows
vim.keymap.set("n", "<leader>|", vim.cmd.vs, { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>-", vim.cmd.sp, { desc = "Split window horizontally" })

-- Navigate between windows
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Navigate to left window" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Navigate to bottom window" })
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Navigate to top window" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Navigate to right window" })

-- Alternative window navigation with 's' prefix
vim.keymap.set("n", "sh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "sj", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "sk", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set("n", "<C-S-h>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-l>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-k>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-j>", "<C-w>-", { desc = "Decrease window height" })

-- Telescope keymaps
-- Utilise les fonctions globales définies dans telescope.lua
vim.keymap.set("n", "<leader>ff", function() _G.telescope.find_files_all() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() _G.telescope.builtin.live_grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() _G.telescope.builtin.buffers() end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", function() _G.telescope.builtin.help_tags() end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fd", function() _G.telescope.builtin.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fr", function() _G.telescope.builtin.lsp_references() end, { desc = "LSP references" })
vim.keymap.set("n", "<C-g>", function() _G.telescope.builtin.git_files() end, { desc = "Git files" })
vim.keymap.set("n", "sf", function() _G.telescope.find_browser() end, { desc = "Find in browser" })

-- Diagnostics - utilise les fonctions globales définies dans diagnostics.lua
vim.keymap.set("n", "<leader>de", function() _G.diagnostics.enable() end, { desc = "Enable diagnostics" })
vim.keymap.set("n", "<leader>dd", function() _G.diagnostics.disable() end, { desc = "Disable diagnostics" })
vim.keymap.set("n", "<leader>df", function() _G.diagnostics.open_float() end, { desc = "Show diagnostic float" })
vim.keymap.set("n", "[d", function() _G.diagnostics.goto_prev() end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function() _G.diagnostics.goto_next() end, { desc = "Next diagnostic" })

-- Specific tools
-- Navigation
vim.keymap.set("n", "<leader>e", function() _G.neotree.toggle_root() end, { desc = "Explorer NeoTree (Root Dir)" })
vim.keymap.set("n", "<leader>E", function() _G.neotree.toggle_cwd() end, { desc = "Explorer NeoTree (CWD)" })

-- Sessions
vim.keymap.set("n", "<leader>sl", function() _G.sessions.load_session() end, { desc = "Load session" })
vim.keymap.set("n", "<leader>ss", function() _G.sessions.save_session() end, { desc = "Save session" })
vim.keymap.set("n", "<leader>sd", function() _G.sessions.delete_session() end, { desc = "Delete session" })

-- Completion
vim.keymap.set("i", "<C-Space>", function() _G.completion.complete() end, { desc = "Trigger completion" })

-- Specific tools
vim.keymap.set("n", "<leader>mc", "<cmd>MetalsCompile<CR>", { desc = "Metals compile" })

-- Which-key configuration for group labels and advanced mappings
wk.add({
	-- Hidden groups
	{ "<leader>a", hidden = true },
	
	-- Sessions
	{ "<leader>s", group = "+sessions" },

	-- LSP and Code actions
	{ "<leader>c", group = "+code" },
	{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
	{ "<leader>rn", ":IncRename ", desc = "Rename" },
	{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references (Trouble)" },
	{ "<leader>cs", "<cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
	
	-- Debugger
	{ "<leader>d", group = "+debugger" },
	{ "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
	{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
	{ "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Terminate" },
	{ "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step Over" },

	-- Git - utilise notre système Git unifié
	{ "<leader>g", group = "+git" },
	{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
	{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
	{ "<leader>gf", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "File history" },
	{ "<leader>gl", "<cmd>LazyGitFilter<CR>", desc = "Git log" },
	{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
	{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
	{ "<leader>gdo", "<cmd>DiffviewOpen<CR>", desc = "DiffView: Open" },
	{ "<leader>gdh", "<cmd>DiffviewFileHistory %<CR>", desc = "DiffView: File History" },
	{ "<leader>ghp", function() _G.git.preview_hunk() end, desc = "Git: Preview hunk" },
	{ "<leader>ghb", function() _G.git.blame_line() end, desc = "Git: Blame line" },
	{ "<leader>ghB", function() _G.git.toggle_blame() end, desc = "Git: Toggle blame" },

	-- Git Telescope
	{ "<leader>gts", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
	{ "<leader>gtc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
	{ "<leader>gtb", "<cmd>Telescope git_branches<CR>", desc = "Git Branches" },

	-- Goto
	{ "<leader>j", group = "+jump" },
	{ "<leader>ja", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
	{ "<leader>jh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
	{ "<leader>jd", "<cmd>Telescope lsp_definitions<CR>", desc = "Definition" },
	{ "<leader>jD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
	{ "<leader>ji", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementation" },
	{ "<leader>jr", "<cmd>Telescope lsp_references<CR>", desc = "References" },

	-- LSP
	{ "<leader>l", group = "+lsp" },
	{ "<leader>lr", ":IncRename ", desc = "Rename" },
	{ "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "LSP hover" },
	-- Trouble
	{ "<leader>x", group = "+trouble" },
	{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle" },
	{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
	{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
	{ "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix" },
	{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Loclist" },
})
