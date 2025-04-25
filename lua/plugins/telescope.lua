return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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

			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					trouble.toggle("quickfix")
				end,
			})

			local common_iglob_excludes = {
				"--hidden",
				"--iglob",
				"!.git/*",
				"--iglob",
				"!node_modules/*",
				"--iglob",
				"!dist/*",
				"--iglob",
				"!.next/*",
				"--iglob",
				"!.cache/*",
				"--iglob",
				"!build/*",
			}

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						".git/",
						"node_modules",
						"dist/",
						".next/",
						".cache/",
						"build/",
						"coverage",
					},
					vimgrep_arguments = vim.tbl_flatten({
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--no-ignore",
						common_iglob_excludes,
					}),
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
							["<C-t>"] = trouble_telescope.open,
						},
					},
				},
				pickers = {
					find_files = {
						theme = "ivy",
						hidden = true,
						find_command = vim.tbl_flatten({
							"rg",
							"--files",
							common_iglob_excludes,
						}),
					},
					grep_string = {
						additional_args = function()
							return common_iglob_excludes
						end,
					},
					live_grep = {
						additional_args = function()
							return common_iglob_excludes
						end,
					},
					oldfiles = {
						theme = "ivy",
						only_cwd = true,
					},
					buffers = {
						theme = "ivy",
						sort_mru = true,
						ignore_current_buffer = true,
					},
				},
				extensions = {
					["ui-select"] = require("telescope.themes").get_dropdown({}),
				},
			})

			local builtin = require("telescope.builtin")
			local lga = require("telescope").extensions.live_grep_args

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					no_ignore = true,
					hidden = true,
					prompt_prefix = "🔍 ",
				})
			end, { desc = "Find files (all)" })

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fga", lga.live_grep_args, { desc = "Live grep (args)" })
			vim.keymap.set("n", "<leader>fG", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep string (manual input)" })

			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = "~/.config/nvim" })
			end, { desc = "Find in nvim config" })
			vim.keymap.set("n", "<leader>fB", builtin.git_status, { desc = "Git status" })
			vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
			vim.keymap.set("n", "<leader>fC", builtin.git_bcommits, { desc = "Git buffer commits" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
