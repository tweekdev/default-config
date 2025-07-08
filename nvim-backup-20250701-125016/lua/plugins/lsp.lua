return {
	-- Mason package manager pour les serveurs LSP
	{
		"williamboman/mason.nvim",
		lazy = false,
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua", -- Formatteur Lua
				"lua-language-server", -- Serveur Lua
				"shfmt",   -- Formatteur Shell
				"eslint_d", -- Linter JavaScript/TypeScript
				"prettier", -- Formatteur multi-langage
				"tailwindcss-language-server", -- Serveur Tailwind CSS
				"emmet-ls", -- Serveur Emmet
				"html-lsp", -- Serveur HTML
				"css-lsp", -- Serveur CSS
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			-- Mise à jour automatique après installation réussie
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			-- Installation automatique des outils configurés
			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},

	-- Bridge entre Mason et LSP config
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},

	-- Configuration principale des serveurs LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "jose-elias-alvarez/typescript.nvim" },
		lazy = false,
		config = function()
			-- Configuration des capacités LSP
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion =
				require("cmp_nvim_lsp").default_capabilities().textDocument.completion

			-- Flags génériques pour les serveurs LSP
			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 300,
			}

			local opts = { noremap = true, silent = true }
			local lspconfig = require("lspconfig")

			-- Configuration simplifiée des serveurs LSP
			local servers = {
				"ts_ls",
				"solargraph",
				"html",
				"lua_ls",
				"tailwindcss",
				"astro",
				"emmet_ls",
				"intelephense",
				"eslint",
				"cssls",
			}

			-- Configuration robuste pour tous les serveurs
			for _, server in ipairs(servers) do
				local server_config = {
					capabilities = capabilities,
					flags = lsp_flags,
				}
				
				-- Configuration spécifique pour certains serveurs
				if server == "lua_ls" then
					server_config.settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					}
				elseif server == "tailwindcss" then
					server_config.filetypes = {
						"html", "css", "scss", "javascript", "javascriptreact", 
						"typescript", "typescriptreact", "vue", "svelte"
					}
					server_config.settings = {
						tailwindCSS = {
							classAttributes = {"class", "className", "classList", "ngClass"},
							lint = {
								cssConflict = "warning",
								invalidApply = "error",
								invalidConfigPath = "error",
								invalidScreen = "error",
								invalidTailwindDirective = "error",
								invalidVariant = "error",
								recommendedVariantOrder = "warning"
							},
							validate = true
						}
					}
				elseif server == "emmet_ls" then
					server_config.filetypes = {
						"html", "css", "scss", "javascript", "javascriptreact",
						"typescript", "typescriptreact", "vue", "svelte"
					}
				end
				
				-- Setup avec gestion d'erreur
				local success, _ = pcall(function()
					lspconfig[server].setup(server_config)
				end)
				
				if not success then
					vim.notify("Serveur LSP '" .. server .. "' non disponible", vim.log.levels.WARN)
				end
			end

			-- Configuration de l'UI pour les fenêtres hover
			vim.lsp.buf.hover({
				border = "rounded",
				max_height = math.floor(vim.o.lines * 0.3),
				max_width = math.floor(vim.o.columns * 0.4),
			})

			-- Diagnostics configuration
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
			})
		end,
	},

	-- Amélioration du completion avec emoji
	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
	},
}
