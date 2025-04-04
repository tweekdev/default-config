return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { ".git/", "node_modules" },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--no-ignore", -- **This is the added flag**
						"--hidden", -- **Also this flag. The combination of the two is the same as `-uu`**
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
					},
					grep_string = {
						additional_args = { "--hidden" },
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {
				desc = "Find files",
			})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			vim.keymap.set("n", "<leader>fgg", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					no_ignore = true,
					hidden = true,
					prompt_prefix = "🔍 ",
				})
			end)

			require("telescope").load_extension("ui-select")
		end,
	},
}
