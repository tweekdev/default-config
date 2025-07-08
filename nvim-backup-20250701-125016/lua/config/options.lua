-- Configuration Neovim optimisée pour les performances
local opt = vim.opt

-- Configuration globale
vim.g.lazyvim_prettier_needs_config = false
vim.cmd("let g:netrw_liststyle = 3")

-- Configuration undo optimisée
if vim.bo.modifiable then
    opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    opt.undofile = true
    opt.undolevels = 1000  -- Limiter pour économiser la mémoire
end

-- Performance et réactivité optimisées
opt.updatetime = 300     -- Augmenté pour de meilleures performances
opt.timeoutlen = 500     -- Délai plus court pour les mappings
opt.ttimeoutlen = 50     -- Délai très court pour les codes de touche
opt.lazyredraw = false   -- CORRECTION: Réactiver le redraw pour éviter les problèmes d'affichage
opt.synmaxcol = 200      -- Limiter la coloration syntaxique sur les longues lignes

-- Interface et affichage
opt.number = true          -- Afficher les numéros de ligne
opt.relativenumber = true  -- Numéros de ligne relatifs
opt.signcolumn = "yes"     -- Colonne de signes toujours visible
opt.cmdheight = 1          -- CORRECTION: Hauteur de ligne de commande visible
opt.laststatus = 3         -- CORRECTION: Barre de statut globale
opt.scrolloff = 8         -- Réduit pour de meilleures performances
opt.title = true           -- Afficher le titre du fichier dans la barre de titre
opt.showcmd = true        -- CORRECTION: Réactiver pour voir les commandes
opt.termguicolors = true   -- Utiliser les couleurs 24-bit (true color)
opt.background = "dark"    -- Thème sombre
opt.wrap = false           -- Ne pas enrouler les lignes
opt.cursorline = true     -- CORRECTION: Réactiver pour meilleure visibilité

-- Recherche optimisée
opt.incsearch = true       -- Recherche incrémentale
opt.hlsearch = true        -- Mettre en surbrillance les résultats de recherche
opt.ignorecase = true      -- Ignorer la casse dans les recherches
opt.smartcase = true       -- Casse intelligente
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
opt.autoindent = true      -- Indentation automatique
opt.smartindent = true     -- Indentation intelligente
opt.expandtab = true       -- Convertir les tabulations en espaces
opt.smarttab = true        -- Tabulation intelligente
opt.breakindent = true     -- Conserver l'indentation sur les lignes enroulées
opt.shiftwidth = 2         -- Largeur de l'indentation
opt.tabstop = 2            -- Largeur visuelle des tabulations
opt.softtabstop = 2        -- Nombre d'espaces insérés pour une tabulation

-- Fenêtres et splits
opt.splitright = true      -- Ouvrir les splits verticaux à droite
opt.splitbelow = true      -- Ouvrir les splits horizontaux en bas
opt.splitkeep = "cursor"   -- Maintenir la position du curseur lors des splits

-- Encodage et formats
opt.isfname:append("@-@") -- Caractères autorisés dans les noms de fichiers
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.formatoptions:append({ "r" }) -- Ajouter des astérisques dans les commentaires en bloc

-- Système et intégrations optimisées
opt.clipboard = "unnamedplus" -- Utiliser le presse-papier système pour le yank
opt.mouse = ""              -- Désactiver la souris
opt.backup = false          -- Pas de fichiers de sauvegarde
opt.swapfile = false        -- Pas de fichiers swap
opt.writebackup = false     -- Pas de sauvegarde temporaire
opt.backspace = { "start", "eol", "indent" } -- Comportement de la touche backspace
opt.inccommand = "split"    -- Afficher les remplacements en temps réel

-- Optimisations mémoire
opt.hidden = true          -- Permettre les buffers cachés
opt.history = 1000         -- Limiter l'historique
opt.maxmempattern = 2000   -- Limiter la mémoire pour les patterns

-- Configuration des diagnostics optimisée
vim.diagnostic.config({
  signs = true,
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  update_in_insert = true, -- CORRECTION: Permettre les mises à jour en mode insertion
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,      -- Optimisation
    border = "rounded",
    source = "if_many",     -- Optimisation
    header = "",
    prefix = "",
  },
})

-- Désactiver les providers inutiles pour de meilleures performances
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Optimisations globales
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
