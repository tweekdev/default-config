-- DISABLED: Codeium temporarily disabled due to download issues
-- You can re-enable it later when the server download is fixed
return {}

--[[
return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "BufEnter",
	config = function()
		require("codeium").setup({
			enable_chat = true,
		})
	end,
}
--]]
