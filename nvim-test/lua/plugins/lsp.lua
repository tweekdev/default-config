-- DISABLED: Configuration LSP complexe remplacée par lsp-simple.lua
return {}

--[[
Original complex config:
return {
	-- Mason package manager pour les serveurs LSP
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				"stylua", -- Formatteur Lua
				"shfmt",   -- Formatteur Shell
				"eslint_d", -- Linter JavaScript/TypeScript
				"prettier", -- Formatteur multi-langage
				"lua-language-server", -- Serveur Lua
				"typescript-language-server",
				"tailwindcss-language-server", -- Serveur Tailwind CSS
				"emmet-ls", -- Serveur Emmet
				"html-lsp", -- Serveur HTML
				"css-lsp", -- Serveur CSS
				"shellcheck",
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
		"mason-org/mason-lspconfig.nvim",
		config = function() end,
	},

	-- Configuration principale des serveurs LSP (LazyVim style)
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			---@class PluginLspOpts
			local ret = {
				-- Options pour vim.diagnostic.config()
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
					},
					severity_sort = true,
								signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = (LazyVim and LazyVim.config.icons.diagnostics.Error) or "✘",
					[vim.diagnostic.severity.WARN] = (LazyVim and LazyVim.config.icons.diagnostics.Warn) or "▲",
					[vim.diagnostic.severity.HINT] = (LazyVim and LazyVim.config.icons.diagnostics.Hint) or "⚑",
					[vim.diagnostic.severity.INFO] = (LazyVim and LazyVim.config.icons.diagnostics.Info) or "»",
				},
			},
				},

				-- Inlay hints (Neovim >= 0.10.0)
				inlay_hints = {
					enabled = true,
					exclude = { "vue" },
				},

				-- Code lenses (Neovim >= 0.10.0)
				codelens = {
					enabled = false,
				},

				-- Capacités globales
				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},

				-- Options pour vim.lsp.buf.format
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},

				-- Configuration des serveurs LSP
				servers = {
					-- Lua
					lua_ls = {
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},

					-- TypeScript/JavaScript
					ts_ls = {
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "literal",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = false,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
							javascript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
						},
					},

					-- CSS
					cssls = {},

					-- HTML
					html = {
						filetypes = { "html", "templ" },
					},

					-- Tailwind CSS
					tailwindcss = {
						root_dir = function(...)
							return require("lspconfig.util").root_pattern(".git")(...)
						end,
					},

					-- Emmet
					emmet_ls = {
						filetypes = {
							"html",
							"css",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
						},
					},

					-- Shell
					bashls = {},

					-- JSON
					jsonls = {},
				},

				-- Configuration personnalisée des serveurs
				setup = {
					-- Exemple pour TypeScript
					-- ts_ls = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
				},
			}
			return ret
		end,

		---@param opts PluginLspOpts
		config = function(_, opts)
					-- Setup autoformat (si LazyVim disponible)
		if LazyVim and LazyVim.format then
			LazyVim.format.register(LazyVim.lsp.formatter())
		end

					-- Setup keymaps
		if LazyVim and LazyVim.lsp then
			LazyVim.lsp.on_attach(function(client, buffer)
				require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			LazyVim.lsp.setup()
			LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)
		else
			-- Configuration LSP basique sans LazyVim
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				end,
			})
		end

			-- Diagnostics signs pour Neovim < 0.10
			if vim.fn.has("nvim-0.10.0") == 0 then
				if type(opts.diagnostics.signs) ~= "boolean" then
					for severity, icon in pairs(opts.diagnostics.signs.text) do
						local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
						name = "DiagnosticSign" .. name
						vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
					end
				end
			end

					-- Inlay hints pour Neovim >= 0.10
		if vim.fn.has("nvim-0.10") == 1 then
			if opts.inlay_hints.enabled then
				if LazyVim and LazyVim.lsp then
					LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
						if
							vim.api.nvim_buf_is_valid(buffer)
							and vim.bo[buffer].buftype == ""
							and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
						then
							vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
						end
					end)
				else
					-- Configuration directe des inlay hints
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							if client and client.supports_method("textDocument/inlayHint") then
								vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
							end
						end,
					})
				end
			end

			-- Code lens
			if opts.codelens.enabled and vim.lsp.codelens then
				if LazyVim and LazyVim.lsp then
					LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = buffer,
							callback = vim.lsp.codelens.refresh,
						})
					end)
				else
					-- Configuration directe des code lens
					vim.api.nvim_create_autocmd("LspAttach", {
						callback = function(args)
							local client = vim.lsp.get_client_by_id(args.data.client_id)
							if client and client.supports_method("textDocument/codeLens") then
								vim.lsp.codelens.refresh()
								vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
									buffer = args.buf,
									callback = vim.lsp.codelens.refresh,
								})
							end
						end,
					})
				end
			end
		end

					-- Configuration des diagnostics avec icônes
		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = (LazyVim and LazyVim.config.icons.diagnostics) or {
						Error = "✘",
						Warn = "▲", 
						Hint = "⚑",
						Info = "»"
					}
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})
				if server_opts.enabled == false then
					return
				end

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- Configuration avec mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.enabled ~= false then
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end
			end

					if have_mason then
			mlsp.setup({
				ensure_installed = vim.tbl_deep_extend(
					"force",
					ensure_installed,
					(LazyVim and LazyVim.opts and LazyVim.opts("mason-lspconfig.nvim").ensure_installed) or {}
				),
				handlers = { setup },
			})
		end
		end,
	},
}
--]]
