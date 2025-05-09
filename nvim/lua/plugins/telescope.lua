return {
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {},
	},
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
						layout_config = {
							vertical = { width = 0.9 },
							-- other layout configuration here
						  },
						hidden = true,
						find_command = vim.tbl_flatten({
							"rg",
							"--files",
							common_iglob_excludes,
						}),
						theme = "dropdown",
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

            -- Export functions for use in keymaps.lua
            _G.telescope = _G.telescope or {}
            _G.telescope.builtin = require("telescope.builtin")
            _G.telescope.lga = require("telescope").extensions.live_grep_args
            
            -- Define custom telescope functions
            _G.telescope.find_files_all = function()
                _G.telescope.builtin.find_files({
                    no_ignore = true,
                    hidden = true,
                    prompt_prefix = "🔍 ",
                })
            end
            
            _G.telescope.grep_input = function()
                _G.telescope.builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end
            
            _G.telescope.find_in_nvim_config = function()
                _G.telescope.builtin.find_files({ cwd = "~/.config/nvim" })
            end
            
            -- Définir uniquement les raccourcis spécifiques à Telescope et pas dans keymaps.lua
            vim.keymap.set("n", "<leader>fga", _G.telescope.lga.live_grep_args, { desc = "Live grep (args)" })
            vim.keymap.set("n", "<leader>fG", _G.telescope.grep_input, { desc = "Grep string (manual input)" })
            vim.keymap.set("n", "<leader><leader>", _G.telescope.builtin.oldfiles, { desc = "Recent files" })
            vim.keymap.set("n", "<leader>fn", _G.telescope.find_in_nvim_config, { desc = "Find in nvim config" })
            vim.keymap.set("n", "<leader>fB", _G.telescope.builtin.git_status, { desc = "Git status" })
            vim.keymap.set("n", "<leader>fc", _G.telescope.builtin.git_commits, { desc = "Git commits" })
            vim.keymap.set("n", "<leader>fC", _G.telescope.builtin.git_bcommits, { desc = "Git buffer commits" })

            -- Fonction pour trouver le dossier courant
            _G.telescope.buffer_dir = function()
                return vim.fn.expand("%:p:h")
            end
            
            -- Fonction pour rechercher dans le dossier courant
            _G.telescope.find_in_buffer_dir = function()
                _G.telescope.builtin.find_files({
                    path = "%:p:h",
                    cwd = _G.telescope.buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end
            
            vim.keymap.set("n", "sf", _G.telescope.find_in_buffer_dir, { desc = "Find in buffer dir" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
