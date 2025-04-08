-- return {
-- 	"m4xshen/autoclose.nvim",
-- 	config = function()
-- 		require("autoclose").setup()
-- 	end,
-- }
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
	-- use opts = {} for passing setup options
	-- this is equivalent to setup({}) function
	opts_extend = { "disable_filetype" },
	opts = {
		ts_config = { java = false },
		check_ts = true,

		fast_wrap = {
			map = "<C-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub("%s+", ""),
			end_key = "$",
			before_key = "h",
			after_key = "l",
			cursor_pos_before = true,
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			manual_position = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
	},
}
