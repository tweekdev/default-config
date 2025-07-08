-- Configuration simplifiée d'auto-pairing
return {
	"altermo/ultimate-autopair.nvim",
	event = { "InsertEnter", "CmdlineEnter" },
	branch = "v0.6",
	config = function()
		require("ultimate-autopair").setup({
			-- Configuration minimale et stable
			tabout = {
				enable = true,
				hopout = true,
			},
			fastwarp = {
				enable = true,
				map = "<C-A-e>",
				rmap = "<C-A-E>",
			},
			close = {
				enable = true,
				map = "<A-]>",
			},
			-- Pas de configuration de paires internes pour éviter les conflits
			-- Les paires par défaut fonctionnent très bien
		})
	end,
}
