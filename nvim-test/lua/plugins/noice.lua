return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			-- The kind of popup to use for lsp progress messages
			progress = {
				enabled = false, -- Disable LSP progress messages completely
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			-- Disable LSP messages in cmdline
			message = {
				enabled = false,
			},
		},
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI
			view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			opts = {}, -- global options for the cmdline. See section on views
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view) View to use for rendering the cmdline
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { pattern = "^/", icon = " ", lang = "regex" },
				search_up = { pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = {}, -- Used by input()
			},
		},
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			enabled = true, -- enables the Noice messages UI
			view = "notify", -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = false, -- view for search count messages. Set to `false` to disable
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			backend = "nui", -- backend to use to show regular cmdline completions
			kind_icons = {}, -- set to `false` to disable icons
		},
		routes = {
			-- Hide all LSP messages completely
			{
				filter = {
					any = {
						{ event = "lsp" },
						{ event = "msg_show", find = "Language Server" },
						{ event = "msg_show", find = "language server" },
						{ event = "msg_show", find = "LSP" },
						{ event = "msg_show", find = "tsserver" },
						{ event = "msg_show", find = "typescript" },
						{ event = "msg_show", find = "eslint" },
						{ event = "msg_show", find = "tailwindcss" },
						{ event = "msg_show", find = "lua_ls" },
						{ event = "msg_show", find = "emmet" },
						{ event = "msg_show", find = "formatting" },
						{ event = "msg_show", find = "diagnostics" },
						{ event = "msg_show", find = "progress" },
						{ event = "msg_show", find = "Spawning" },
						{ event = "msg_show", find = "Client.*quit" },
						{ event = "msg_show", find = "attached" },
						{ event = "msg_show", find = "detached" },
						{ event = "notify", find = "Language Server" },
						{ event = "notify", find = "language server" },
						{ event = "notify", find = "LSP" },
					},
				},
				opts = { skip = true },
			},
			-- Hide completion messages that interfere with cmdline
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "completion" },
						{ find = "match %d+ of %d+" },
						{ find = "^%d+ matches?" },
					},
				},
				opts = { skip = true },
			},
			-- Original routes
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
			{
				filter = {
					event = "notify",
					find = "No information",
				},
				opts = { skip = true },
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- DISABLED: position the cmdline and popupmenu together (causes conflicts)
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = true, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
  -- stylua: ignore
  keys = {
    { "<leader>sn",  "",                                                                            desc = "+noice" },
    { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
    { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
  },
	config = function(_, opts)
		-- HACK: noice shows messages from before it was enabled,
		-- but this is not ideal when Lazy is installing plugins,
		-- so clear the messages in this case.
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)
		require("notify").setup({
			-- other stuff
			background_colour = "#000000",
		})
	end,
}
