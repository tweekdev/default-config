-- Configuration du dashboard avec Alpha-nvim
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    
    -- En-tête personnalisé (logo ASCII art)
    dashboard.section.header.val = {
      [[                                                    ]],
      [[                                                    ]],
      [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[                                                    ]],
      [[                                                    ]],
    }
    
    -- Raccourcis personnalisés
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":lua _G.telescope.find_files_all()<CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("t", "  Find text", ":lua _G.telescope.builtin.live_grep()<CR>"),
      dashboard.button("s", "  Load session", ":lua _G.sessions.load_session()<CR>"),
      --dashboard.button("p", "  Projects", ":Telescope projects<CR>"),
      dashboard.button("g", "  Git status", ":LazyGit<CR>"),
      dashboard.button("c", "  Configuration", ":e ~/.config/dotfiles/nvim/init.lua<CR>"),
      dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }
    
    -- Pieds de page
    local function footer()
      local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/lazy", "*", 0, 1))
      local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
      local version = vim.version()
      local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
      
      return datetime .. "   " .. plugins_count .. " plugins" .. nvim_version_info
    end
    
    dashboard.section.footer.val = footer()
    
    -- Mise en page
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    
    -- Espacements
    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }
    
    -- Configuration des options
    dashboard.config.opts.noautocmd = true
    
    -- Couleurs personnalisées
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa" })
        vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#cba6f7" })
        vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#a6e3a1" })
      end,
    })
    
    -- Initialize alpha
    alpha.setup(dashboard.config)
    
    -- Exécuter la commande pour définir les couleurs au démarrage
    vim.cmd("colorscheme " .. vim.g.colors_name)
  end,
}
