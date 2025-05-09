return {
	"dgagn/diagflow.nvim",
	event = { "LspAttach", "BufReadPost" },
	opts = {
		placement = "inline",
		inline_padding_left = 3,
		update_event = { "DiagnosticChanged", "BufReadPost" },
		toggle_event = {}, -- Laisser vide pour ne pas afficher en mode insertion
		show_sign = false,
		render_event = { "DiagnosticChanged", "CursorMoved" },
		-- Utiliser les mêmes couleurs que notre configuration centralisée
		severity_colors = {
			error = "DiagnosticFloatingError",
			warning = "DiagnosticFloatingWarn",
			info = "DiagnosticFloatingInfo",
			hint = "DiagnosticFloatingHint",
		},
		format = function(diagnostic)
			-- Format plus informatif avec source (VSCode-like)
			if diagnostic.source then
				return string.format("%s (%s)", diagnostic.message, diagnostic.source)
			else
				return diagnostic.message
			end
		end,
	},
	config = function(_, opts)
		-- Ajouter la fonction à l'objet global de diagnostics
		_G.diagnostics = _G.diagnostics or {}
		
		-- Configuration de diagflow
		require("diagflow").setup(opts)
		
		-- Ajouter une fonction de toggle pour diagflow
		_G.diagnostics.toggle_diagflow = function()
			local diagflow = require("diagflow")
			if diagflow.is_enabled() then
				diagflow.disable()
				vim.notify("Inline diagnostics disabled", vim.log.levels.INFO)
			else
				diagflow.enable()
				vim.notify("Inline diagnostics enabled", vim.log.levels.INFO)
			end
		end
		
		-- Ajouter un raccourci pour activer/désactiver diagflow
		vim.keymap.set("n", "<leader>di", function() _G.diagnostics.toggle_diagflow() end,
			{ desc = "Toggle inline diagnostics" })
	end,
}
