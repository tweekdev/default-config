return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		-- Default options
		require("github-theme").setup({
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/github-theme",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
				hide_nc_statusline = true, -- Override the underline style for non-active statuslines
				transparent = true, -- Disable setting bg (make neovim's background transparent)
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				styles = { -- Style to be applied to different syntax groups
					comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
					functions = "NONE",
					keywords = "NONE",
					variables = "NONE",
					conditionals = "NONE",
					constants = "NONE",
					numbers = "NONE",
					operators = "NONE",
					strings = "NONE",
					types = "NONE",
				},
				inverse = { -- Inverse highlight for different types
					match_paren = false,
					visual = false,
					search = false,
				},
				darken = { -- Darken floating windows and sidebar-like windows
					floats = true,
					sidebars = {
						enable = true,
						list = {}, -- Apply dark background to specific windows
					},
				},
				modules = { -- List of various plugins and additional options
					-- ...
				},
			},
			palettes = {
				-- Everything defined under `all` will be applied to each style.
				all = {
					-- Each palette defines these colors:
					--   black, gray, blue, green, magenta, pink, red, white, yellow, cyan
					--
					-- These colors have 2 shades: base, and bright

					-- Passing a string sets the base
					--red = "#ff0000",
				},
				-- github_dark = {
				-- 	-- Defining multiple shades is done by passing a table
				-- 	red = {
				-- 		base = "#8e1519",
				-- 		bright = "#ee0000",
				-- 	},
				-- },
				github_dark_dimmed = {
					-- A palette also defines the following:
					--   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
					--
					-- These are the different foreground and background shades used by the theme.
					-- The base bg and fg is 1, 0 is normally the dark alternative. The others are
					-- incrementally lighter versions.

					-- bg0 is the default bg
					-- sel is different types of selection colors
					-- bg1 = "#191919", -- Black background
					-- bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
					-- bg3 = "#121820", -- 55% darkened from stock
					-- sel0 = "#adbac7", -- Popup bg, visual selection bg
					-- sel1 = "#22272e", -- Popup sel bg, search bg
					--
					-- -- comment is the definition of the comment color.
					-- comment = "#636e7b",
				},
			},
			specs = {
				-- all = {
				-- 	inactive = "bg0", -- Default value for other styles
				-- },
				-- github_dark_dimmed = {
				-- 	bg0 = "#1d1d2b",
				-- 	bg1 = "#1A1A1A",
				-- 	inactive = "#090909", -- Slightly lighter then black background
				-- },
			},
			groups = {
				all = {
					-- NormalNC = { fg = "fg1", bg = "inactive" }, -- Non-current windows
				},
			},
		})

		-- setup must be called before loading
		--vim.cmd("colorscheme github_dark")
		vim.cmd("colorscheme github_dark_dimmed")
	end,
}
