return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	opts = {},
	cmd = { "Refactor" },
	keys = {
		{ "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<CR>", desc = "Extract function" },
		{
			"<leader>rf",
			"<cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
			desc = "Extract function to file",
		},
		{ "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", desc = "Extract variable" },
		{ "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "Inline variable" },
		{
			"<leader>rbb",
			"<cmd>lua require('refactoring').refactor('Extract Block')<CR>",
			desc = "Extract block",
		},
		{
			"<leader>rbf",
			"<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
			desc = "Extract block to file",
		},
		{
			"<leader>rR",
			"<cmd>lua require('refactoring').select_refactor()<CR>",
			desc = "Select refactor",
		},
		{
			"<leader>rI",
			"<cmd>lua require('refactoring').refactor('Inline Function')<CR>",
			desc = "Inline function",
		},
		{
			"<leader>rv",
			"<cmd>lua require('refactoring').debug.print_var()<CR>",
			desc = "Print variable under cursor",
		},
	},
	config = function()
		require("telescope").load_extension("refactoring")
		require("refactoring").setup({
			prompt_func_return_type = {
				go = true,
				cpp = true,
				c = true,
				java = true,
				typescript = true,
				typescriptreact = true,
				python = true,
				javascript = true,
			},
			prompt_func_param_type = {
				go = true,
				cpp = true,
				c = true,
				java = true,
				typescript = true,
				python = true,
				javascript = true,
			},
			prompt_func_param_name = {
				go = true,
				cpp = true,
				c = true,
				java = true,
				typescript = true,
				python = true,
				javascript = true,
			},
			print_var_statements = {
				typescript = {
					"console.log('print $1:', $2)",
				},
				javascript = {
					"console.log('print $1:', $2)",
				},
			},
		})

		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("telescope").extensions.refactoring.refactors()
		end)
	end,
}
