-- Système de complétion optimisé
return {
	-- Sources de complétion LSP
	{
		"hrsh7th/cmp-nvim-lsp",
		commit = "99290b3", -- Version stable fixée
		dependencies = { "hrsh7th/cmp-emoji" },
	},
	
	-- Sources de complétion additionnelles
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" },    -- Mots du buffer actuel
	{ "hrsh7th/cmp-path", event = "InsertEnter" },      -- Chemins de fichiers
	{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },  -- Commandes Vim
	{ "hrsh7th/cmp-nvim-lua", ft = "lua" },            -- API Neovim Lua
	
	-- Système de snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp", -- Support des expressions régulières
		dependencies = {
			"saadparwaiz1/cmp_luasnip",      -- Source LuaSnip pour cmp
			"rafamadriz/friendly-snippets",   -- Collection de snippets prêts à l'emploi
			"iurimateus/luasnip-latex-snippets.nvim", -- Snippets LaTeX
		},
		config = function()
			-- Configure LuaSnip
			local luasnip = require("luasnip")
			
			-- Options de base
			luasnip.config.set_config({
				history = true,  -- Conserver l'historique des snippets
				updateevents = "TextChanged,TextChangedI", -- Mise à jour en temps réel
				enable_autosnippets = true,
				ext_opts = {
					[require("luasnip.util.types").choiceNode] = {
						active = {
							virt_text = { { "← Choix disponibles", "GruvboxOrange" } },
						},
					},
				},
			})
			
			-- Chargement des snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets/" })
			
			-- Définir un espace global pour les snippets personnalisés
			_G.luasnip = _G.luasnip or {}
			_G.luasnip.add_snippet = function(filetype, snippet)
				luasnip.add_snippets(filetype, {snippet})
				vim.notify("Snippet ajouté pour " .. filetype, vim.log.levels.INFO)
			end
		end,
	},
	
	-- Icônes pour la complétion
	{
		"onsails/lspkind.nvim",
		lazy = true,
		config = function()
			require("lspkind").init()
		end,
	},
	
	-- Le moteur de complétion principal
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"onsails/lspkind.nvim", -- Icônes dans le menu de complétion
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			
			-- Définir des couleurs plus attrayantes pour le menu de complétion
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", italic = true })
			
			-- Ajouter la complétion pour les commandes Vim
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
			
			-- Configuration globale
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				
				-- Apparence améliorée des fenêtres
				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
						scrollbar = true,
						side_padding = 1,
					},
					documentation = {
						border = "rounded",
						winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:CmpDocSel,Search:None",
						max_width = 60,
						max_height = 20,
					},
				},
				
				-- Formater les items pour afficher des icônes
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							-- Afficher la source de complétion
							vim_item.menu = ({ 
								copilot = "[AI]",
								codeium = "[AI]",
								nvim_lsp = "[LSP]",
								luasnip = "[SNP]",
								buffer = "[BUF]",
								path = "[PTH]",
								cmdline = "[CMD]",
								emoji = "[EMJ]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},
				
				-- Options avancées
				performance = {
					max_view_entries = 20, -- Limiter le nombre d'entrées affichées
				},
				experimental = {
					ghost_text = true, -- Texte fantôme pour montrer le résultat
				},
				
				-- Raccourcis clavier optimisés
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ 
						select = false,
						behavior = cmp.ConfirmBehavior.Replace 
					}),
					
					-- Navigation améliorée avec Tab/S-Tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							if entry and entry.source.name == "copilot" then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif vim.snippet and vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),
					
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						elseif vim.snippet and vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				
				-- Sources de complétion par ordre de priorité
				sources = cmp.config.sources({
					{ name = "copilot", group_index = 1, priority = 100 },
					{ name = "codeium", group_index = 1, priority = 90 },
					{ name = "nvim_lsp", group_index = 1, priority = 80 },
					{ name = "luasnip", group_index = 1, priority = 70 },
					{ name = "nvim_lua", group_index = 2, priority = 60 },
					{ name = "path", group_index = 2, priority = 50 },
					{ name = "buffer", group_index = 2, priority = 40 },
					{ name = "emoji", group_index = 3, priority = 30 },
				}),
				
				-- Options de tri
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.exact,      -- Correspondance exacte en premier
						cmp.config.compare.score,      -- Score algorithmique
						cmp.config.compare.kind,       -- Type d'item
						cmp.config.compare.length,     -- Longueur du mot
						cmp.config.compare.order,      -- Ordre des sources
					},
				},
			})
			
			-- Exporter les fonctions pour utilisation globale
			_G.completion = _G.completion or {}
			_G.completion.complete = function()
				cmp.complete()
			end
			
			-- Reconfigurer à chaque changement de colorscheme
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("completion_colors", { clear = true }),
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bold = true })
					vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bold = true })
					vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", italic = true })
				end,
			})
		end,
	},
}
