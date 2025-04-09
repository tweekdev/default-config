-- return { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} }
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons", "rose-pine/neovim" },
	opts = {
		-- style_preset = bufferline.style_preset.minimal,
		highlights = {
			buffer_selected = { italic = false, bold = true },
			diagnostic_selected = { italic = false },
			hint_selected = { italic = false },
			pick_selected = { italic = false },
			pick_visible = { italic = false },
			pick = { italic = false },
			separator = { bg = "#1f2335", fg = "#1f2335" },
		},
		options = {
			offsets = {
				{
					filetype = "neo-tree",
					--text = "Nvim Tree",
					separator = false,
					text_align = "left",
				},
			},
			diagnostics = "nvim_lsp",
			separator_style = "thick",
			modified_icon = "●",
			show_close_icon = false,
			show_buffer_close_icons = true,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or (level:match("warning") and " ") or " "
				return " " .. icon .. count
			end,
		},
	},
	event = "ColorScheme",
	config = function()
		local highlights = require("rose-pine.plugins.bufferline")
		require("bufferline").setup({ highlights = highlights })
	end,
}
