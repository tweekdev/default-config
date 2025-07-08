-- return { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} }
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons", "projekt0n/github-nvim-theme" },
  config = function()
    --local highlights = require("rose-pine.plugins.bufferline")
    --highlights.fill = { bg = "#191919", fg = "#ffffff" }
    --highlights.tab = { bg = "#191919", fg = "#ffffff" }
    --highlights.tab_selected = { bg = "#191919", fg = "#ffffff" }
    --highlights.buffer_selected = { bg = "#292929", fg = "#ffffff" }
    --highlights.background = { bg = "#191919", fg = "#ffffff" }
    --require("bufferline").setup({ highlights = highlights })
    local groups = require("bufferline.groups")

    groups.setup({
      options = {
        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        offsets = {
          { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left" },
        },
        items = {
          {
            name = "Tests", -- Mandatory
            highlight = { underline = true, sp = "blue" }, -- Optional
            priority = 2, -- determines where it will appear relative to other groups (Optional)
            icon = " ", -- Optional
            matcher = function(buf) -- Mandatory
              return buf.filename:match("%_test") or buf.filename:match("%_spec")
            end,
          },
          {
            name = "Docs",
            highlight = { undercurl = true, sp = "green" },
            auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
            matcher = function(buf)
              return buf.filename:match("%.md") or buf.filename:match("%.txt")
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
        },
      },
    })
  end,

  opts = {
    -- style_preset = bufferline.style_preset.minimal,
    numbers = "buffer_id",
    highlights = {
      --fill = { bg = "#191919", fg = "#191919" },
      --tab = { bg = "#191919", fg = "#191919" },
      --background = { bg = "#191919", fg = "#191919" },
      buffer_selected = { italic = false, bold = true },
      diagnostic_selected = { italic = false },
      hint_selected = { italic = false },
      pick_selected = { italic = false },
      pick_visible = { italic = false },
      pick = { italic = false },
      --separator = { bg = "#1f2335", fg = "#1f2335" },
    },
    -- groups = {
    -- 	options = {
    -- 		toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
    -- 	},
    -- 	items = {
    -- 		{
    -- 			name = "Tests", -- Mandatory
    -- 			highlight = { underline = true, sp = "blue" }, -- Optional
    -- 			priority = 2, -- determines where it will appear relative to other groups (Optional)
    -- 			icon = " ", -- Optional
    -- 			matcher = function(buf) -- Mandatory
    -- 				return buf.filename:match("%_test") or buf.filename:match("%_spec")
    -- 			end,
    -- 		},
    -- 		{
    -- 			name = "Docs",
    -- 			highlight = { undercurl = true, sp = "green" },
    -- 			auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
    -- 			matcher = function(buf)
    -- 				return buf.filename:match("%.md") or buf.filename:match("%.txt")
    -- 			end,
    -- 			separator = { -- Optional
    -- 				style = require("bufferline.groups").separator.tab,
    -- 			},
    -- 		},
    -- 	},
    -- },
    options = {
      themable = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "file explorer",
          --text = "Nvim Tree",
          separator = true,
          text_align = "left",
        },
      },
      diagnostics = "nvim_lsp",
      mode = "tabs",

      buffer_close_icon = "",
      separator_style = "thick",
      modified_icon = "●",
      show_close_icon = false,
      show_buffer_close_icons = false,
      sort_by = "directory",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or (level:match("warning") and " ") or " "
        return " " .. icon .. count
      end,
    },
  },
  event = "ColorScheme",
}
