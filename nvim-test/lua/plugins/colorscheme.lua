return {
  -- Configure LazyVim to load github_dark_dimmed as default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark_dimmed",
    },
  },

  -- GitHub theme as main theme
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
          },
          darken = {
            floats = false, -- Désactivé pour la transparence
            sidebars = {
              enable = false, -- Désactivé pour la transparence
            },
          },
        },
        groups = {
          all = {
            -- Garder seulement les diagnostics sans background pour la transparence
            DiagnosticVirtualTextError = { fg = "palette.danger.fg" },
            DiagnosticVirtualTextWarn = { fg = "palette.attention.fg" },
            DiagnosticVirtualTextInfo = { fg = "palette.accent.fg" },
            DiagnosticVirtualTextHint = { fg = "palette.done.fg" },
          },
        },
      })

      vim.cmd("colorscheme github_dark_dimmed")
    end,
  },

  -- Tokyonight theme as alternative
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Gruvbox theme as alternative
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      transparent_mode = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        folds = true,
      },
    },
  },

  -- Catppuccin theme as alternative
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = true,
        which_key = true,
      },
    },
  },
} 