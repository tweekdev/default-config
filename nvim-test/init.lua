-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Configuration personnalisée (après LazyVim pour pouvoir override)
require("config.options")
require("config.keymaps")
require("config.diagnostics") -- Configuration centralisée des diagnostics

-- LazyVim integration and conflict management
-- Les overrides LazyVim sont gérés automatiquement via lazy.nvim
-- Configuration supplémentaire pour l'intégration LazyVim si nécessaire
