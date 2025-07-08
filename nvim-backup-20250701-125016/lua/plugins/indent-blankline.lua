-- return {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	main = "ibl",
-- 	opts = {
-- 		indent = { char = "┊" },
-- 	},
-- }
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = { char = "│" },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "Trouble",
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "mason",
        "neo-tree",
        "notify",
        "snacks_dashboard",
        "snacks_notif",
        "snacks_terminal",
        "snacks_win",
        "toggleterm",
        "trouble",
      },
    },
  },
  main = "ibl",
}
