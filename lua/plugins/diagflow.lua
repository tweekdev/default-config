return {
	"dgagn/diagflow.nvim",
	opts = {
		placement = "inline",
		inline_padding_left = 3,
		update_event = { "DiagnosticChanged", "BufReadPost" }, -- the event that updates the diagnostics cache
		toggle_event = {}, -- if InsertEnter, can toggle the diagnostics on inserts
		show_sign = false, -- set to true if you want to render the diagnostic sign before the diagnostic message
		render_event = { "DiagnosticChanged", "CursorMoved" },
		severity_colors = { -- The highlight groups to use for each diagnostic severity level
			error = "DiagnosticFloatingError",
			warning = "DiagnosticFloatingWarn",
			info = "DiagnosticFloatingInfo",
			hint = "DiagnosticFloatingHint",
		},
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
}
