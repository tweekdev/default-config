return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		vim.keymap.set("i", "<C-g>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
	end,
}
-- return {
-- 	"zbirenbaum/copilot.lua",
-- 	cmd = "Copilot",
-- 	build = ":Copilot auth",
-- 	event = "BufEnter",
-- 	opts = {
-- 		suggestion = {
-- 			enabled = not vim.g.ai_cmp,
-- 			auto_trigger = true,
-- 			hide_during_completion = vim.g.ai_cmp,
-- 			keymap = {
-- 				accept = false, -- handled by nvim-cmp / blink.cmp
-- 				next = "<M-]>",
-- 				prev = "<M-[>",
-- 			},
-- 		},
-- 		panel = { enabled = false },
-- 		filetypes = {
-- 			markdown = true,
-- 			help = true,
-- 		},
-- 	},
-- }
