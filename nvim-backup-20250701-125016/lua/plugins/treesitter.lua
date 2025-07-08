-- Configuration Treesitter optimisée pour les performances
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- Chargement lazy pour de meilleures performances
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Pour les text objects
  },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Parsers essentiels (sans doublons)
			ensure_installed = {
				"lua",
				"vimdoc",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"bash",
				"markdown",
				"yaml",
				"gitignore",
				-- Ajoutez seulement les langages que vous utilisez vraiment
			},

			-- Performance optimizations
			sync_install = false, -- Installation asynchrone pour de meilleures performances
			auto_install = true,  -- Auto-installation des parsers manquants

			-- Indentation intelligente
			indent = {
				enable = true,
				-- Désactiver pour certains langages problématiques si nécessaire
				disable = {}, 
			},

			-- Coloration syntaxique optimisée
			highlight = {
				enable = true,
				
				-- Désactiver la coloration Vim legacy pour de meilleures performances
				additional_vim_regex_highlighting = false,
				
				-- Désactiver pour les gros fichiers
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},

			-- Désactiver le query linter pour de meilleures performances
			query_linter = {
				enable = false, -- Désactivé pour éviter les ralentissements
			},

			-- Modules additionnels optimisés
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<C-s>",
					node_decremental = "<M-space>",
				},
			},

			-- Text objects pour une navigation efficace
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Regarder vers l'avant pour trouver les objets
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		})

		-- Configuration de folding basée sur Treesitter (optionnel)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = false -- Désactivé par défaut pour de meilleures performances
	end,
}
