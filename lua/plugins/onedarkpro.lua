return {
	--"olimorris/onedarkpro.nvim",
	"navarasu/onedark.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedark").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
			term_colors = true, -- Change terminal color as per the selected theme style

			transparent = false, -- Show/hide background
			style = "warmer", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			transparent = true, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			-- Lualine options --
			lualine = {
				transparent = false, -- lualine center bar transparency
			},
			-- Custom Highlights --
			-- Change code style ---
			-- Options are italic, bold, underline, none
			-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
			code_style = {
				comments = "italic",
				keywords = "none",
				functions = "none",
				strings = "none",
				variables = "none",
			},
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = false },
				keywords = { italic = false },
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			-- Plugins Config --
			diagnostics = {
				darker = false, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		})
	end,
}
