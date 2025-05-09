-- Alias pour plus de concision
local opt = vim.opt

-- Configuration globale
vim.g.lazyvim_prettier_needs_config = false
vim.cmd("let g:netrw_liststyle = 3")

-- Configuration undo
if vim.bo.modifiable then
    opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    opt.undofile = true
end

-- Performance et réactivité
opt.updatetime = 50

-- Interface et affichage
opt.number = true          -- Afficher les numéros de ligne
opt.relativenumber = true  -- Numéros de ligne relatifs
opt.signcolumn = "yes"     -- Colonne de signes toujours visible
opt.cmdheight = 0          -- Hauteur de la ligne de commande
opt.laststatus = 0         -- Barre de statut
opt.scrolloff = 10         -- Garde des lignes visibles au-dessus/en-dessous du curseur
opt.title = true           -- Afficher le titre du fichier dans la barre de titre
opt.showcmd = true         -- Afficher les commandes en cours de frappe
opt.termguicolors = true   -- Utiliser les couleurs 24-bit (true color)
opt.background = "dark"    -- Thème sombre
opt.wrap = false           -- Ne pas enrouler les lignes

-- Recherche
opt.incsearch = true       -- Recherche incrémentale
opt.hlsearch = true        -- Mettre en surbrillance les résultats de recherche
opt.ignorecase = true      -- Ignorer la casse dans les recherches
opt.path:append({ "**" })  -- Chercher dans tous les sous-dossiers
opt.wildignore:append({ "*/node_modules/*" }) -- Ignorer node_modules

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

-- Système et intégrations
opt.clipboard = "unnamedplus" -- Utiliser le presse-papier système pour le yank
opt.mouse = ""              -- Désactiver la souris
opt.backup = false          -- Pas de fichiers de sauvegarde
opt.swapfile = false        -- Pas de fichiers swap
opt.backspace = { "start", "eol", "indent" } -- Comportement de la touche backspace
opt.inccommand = "split"    -- Afficher les remplacements en temps réel

-- Configuration des diagnostics
local default_diagnostic_config = {
	signs = true,
	virtual_text = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		format = function(diagnostic)
			return string.format("%s (%s)", diagnostic.message, diagnostic.source)
		end,
	},
}

-- Appliquer la configuration des diagnostics
vim.diagnostic.config(default_diagnostic_config)
