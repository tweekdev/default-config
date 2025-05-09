return {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
	},
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()

		metals_config.settings = {
			autoImportBuild = "disabled",
			showImplicitArguments = true,
			disableCompileOnSave = true,
			excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
		}

		metals_config.on_attach = function(client, bufnr)
			-- your on_attach function
		end

		metals_config.init_options.statusBarProvider = "off"

		-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
