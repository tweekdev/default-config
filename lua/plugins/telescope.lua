return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local trouble = require("trouble")
			local trouble_telescope = require("trouble.sources.telescope")

			local transform_mod = require("telescope.actions.mt").transform_mod
			-- or create your custom action
			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					trouble.toggle("quickfix")
				end,
			})
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
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
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
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>fG", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)

			vim.keymap.set("n", "<leader>fB", builtin.git_status, {})
			vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>fC", builtin.git_bcommits, {})
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
