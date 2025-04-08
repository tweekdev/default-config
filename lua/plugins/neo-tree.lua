return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = false, -- hide filtered items on open
					hide_gitignored = true,
					hide_dotfiles = false,
					hide_by_name = {
						"package-lock.json",
						".changeset",
						".prettierrc.json",
					},
					never_show = { ".git" },
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
}
