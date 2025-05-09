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
	},
	config = function()
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
					"console.log('print $1 :', $2)",
				},
				javascript = {
					"console.log('print $1 :', $2)",
				},
			},
		})
	end,
}
