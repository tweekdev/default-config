-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker that is available
vim.g.lazyvim_picker = "auto"

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- LazyVim automatically configures lazygit:
--  * theme, based on the active colorscheme.
--  * editorPreset to nvim-remote
--  * enables nerd font icons
-- Set to false to disable.
vim.g.lazygit_config = true

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Configuration globale personnalisée
vim.g.lazyvim_prettier_needs_config = false
vim.cmd("let g:netrw_liststyle = 3")

-- Configuration undo optimisée
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 1000  -- Limiter pour économiser la mémoire

-- Performance et réactivité optimisées
opt.updatetime = 300     -- Augmenté pour de meilleures performances
opt.timeoutlen = 500     -- Délai plus court pour les mappings
opt.ttimeoutlen = 50     -- Délai très court pour les codes de touche
opt.lazyredraw = false   -- CORRECTION: Réactiver le redraw pour éviter les problèmes d'affichage
opt.synmaxcol = 200      -- Limiter la coloration syntaxique sur les longues lignes

-- Interface et affichage personnalisé
opt.cmdheight = 1          -- CORRECTION: Hauteur de ligne de commande visible
opt.laststatus = 3         -- CORRECTION: Barre de statut globale
opt.scrolloff = 8         -- Réduit pour de meilleures performances
opt.title = true           -- Afficher le titre du fichier dans la barre de titre
opt.showcmd = true        -- CORRECTION: Réactiver pour voir les commandes
opt.cursorline = true     -- CORRECTION: Réactiver pour meilleure visibilité

-- Recherche optimisée
opt.path:append({ "**" })  -- Chercher dans tous les sous-dossiers
opt.wildignore:append({ 
  "*/node_modules/*", 
  "*/.git/*", 
  "*/dist/*", 
  "*/build/*",
  "*.pyc",
  "*.o",
  "*.class"
})

-- Indentation et tabulations
opt.shiftwidth = 2         -- Largeur de l'indentation
opt.tabstop = 2            -- Largeur visuelle des tabulations
opt.softtabstop = 2        -- Nombre d'espaces insérés pour une tabulation

-- Fenêtres et splits
opt.splitkeep = "cursor"   -- Maintenir la position du curseur lors des splits

-- Encodage et formats
opt.isfname:append("@-@") -- Caractères autorisés dans les noms de fichiers
opt.formatoptions:append({ "r" }) -- Ajouter des astérisques dans les commentaires en bloc

-- Système et intégrations optimisées
opt.inccommand = "split"    -- Afficher les remplacements en temps réel

-- Optimisations mémoire
opt.history = 1000         -- Limiter l'historique
opt.maxmempattern = 2000   -- Limiter la mémoire pour les patterns

-- Folding
opt.foldmethod = "manual"
opt.foldenable = false

-- Wildmenu
opt.wildmode = "longest:full,full"
