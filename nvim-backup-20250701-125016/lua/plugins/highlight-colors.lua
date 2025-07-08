return {
	"brenoprata10/nvim-highlight-colors",
	opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>uc", function() require("nvim-highlight-colors").toggle() end, desc = "Toggle Highlight Colors" },
  },
}
