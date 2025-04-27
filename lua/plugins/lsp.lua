return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "jose-elias-alvarez/typescript.nvim" },
		lazy = false,
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion =
				require("cmp_nvim_lsp").default_capabilities().textDocument.completion

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 300,
			}
			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "",
				}
				vim.lsp.buf.execute_command(params)
				vim.lsp.buf.format()
			end

			local opts = { noremap = true, silent = true }

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "OrganizeImports",
					})
				end,
				capabilities = capabilities,
				flags = lsp_flags,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})
			lspconfig.astro.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
				flags = lsp_flags,
			})

			vim.lsp.buf.hover({
				border = "rounded",
				max_height = math.floor(vim.o.lines * 0.3),
				max_width = math.floor(vim.o.columns * 0.4),
			}, function(bufnr, winnr, config)
				-- whatever you want to do
			end)

			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definition<CR>", opts) -- show lsp definitions
			vim.keymap.set("n", "<leader>co", "<cmd>OrganizeImports<CR>", opts)
			vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
			-- vim.keymap.set("n", "<leader>gR", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp type definitions
			vim.keymap.set("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
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
	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
	},
}
