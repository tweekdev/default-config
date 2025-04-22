return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint_d"),
				require("none-ls.code_actions.eslint"),
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
			},
		})

		-- Si tu veux garder <leader>gf pour formatter avec conform :
		vim.keymap.set("n", "<leader>gf", function()
			require("conform").format({ lsp_fallback = false })
		end, { desc = "Format via conform" })
	end,
}
