return {
	"dgagn/diagflow.nvim",
	event = { "LspAttach", "BufReadPost" },
	opts = {
		enabled = true,
		-- Utiliser placement 'top' qui gère mieux le wrapping du texte
		placement = "top",
		-- Padding à droite pour le texte (placement 'top')
		padding_right = 1,
		-- Padding en haut pour le texte (placement 'top')
		padding_top = 1,
		-- Alignement du texte
		text_align = "left",
		update_event = { "DiagnosticChanged", "BufReadPost" },
		toggle_event = {}, -- Laisser vide pour ne pas afficher en mode insertion
		show_sign = false,
		render_event = { "DiagnosticChanged", "CursorMoved" },
		-- Largeur maximale avant que le texte ne s'enveloppe
		--max_width = 100,
		-- Nombre maximal de lignes à afficher après enveloppement
		--max_height = 20,

		-- Utiliser les mêmes couleurs que notre configuration centralisée
		border_chars = {
			top_left = "┌",
			top_right = "┐",
			bottom_left = "└",
			bottom_right = "┘",
			horizontal = "─",
			vertical = "│"
		},
		show_borders = true,
		severity_colors = {
			error = "DiagnosticFloatingError",
			warning = "DiagnosticFloatingWarn",
			info = "DiagnosticFloatingInfo",
			hint = "DiagnlosticFloatingHint",
		},
		gap_size = 1,
		format = function(diagnostic)
			-- Format plus informatif avec source (VSCode-like)
			if diagnostic.source then
				return string.format("%s (%s)", diagnostic.message, diagnostic.source)
			else
				return '[LSP] ' .. diagnostic.message
			end
		end,
	},
	config = function(_, opts)
		-- Ajouter la fonction à l'objet global de diagnostics
		_G.diagnostics = _G.diagnostics or {}

		-- S'assurer que les diagnostics Neovim sont activés
		local diagnostics_config = vim.diagnostic.config()
		vim.diagnostic.config({
			virtual_text = false, -- Désactive le texte virtuel par défaut pour éviter les conflits
			signs = diagnostics_config.signs ~= false,
			underline = diagnostics_config.underline ~= false,
			severity_sort = true
		})

		-- Configuration de diagflow
		require("diagflow").setup(opts)
		
		-- Activer diagflow explicitement au démarrage
		vim.defer_fn(function()
			require("diagflow").enable()
			_G.diagnostics.diagflow_enabled = true
		end, 100)

		-- Ajouter une fonction de toggle pour diagflow
		_G.diagnostics.toggle_diagflow = function()
			local diagflow = require("diagflow")
			
			-- Dans l'API actuelle de diagflow, il n'y a pas de is_enabled()
			-- On utilise une approche différente
			-- Stockage de l'état en variable globale
			_G.diagnostics.diagflow_enabled = not (_G.diagnostics.diagflow_enabled or false)
			
			if _G.diagnostics.diagflow_enabled then
				diagflow.enable()
				vim.notify("Inline diagnostics enabled", vim.log.levels.INFO)
			else
				diagflow.disable()
				vim.notify("Inline diagnostics disabled", vim.log.levels.INFO)
			end
		end

		-- Ajouter un raccourci pour activer/désactiver diagflow
		vim.keymap.set("n", "<leader>di", function()
			_G.diagnostics.toggle_diagflow()
		end, { desc = "Toggle inline diagnostics" })
	end,
}
