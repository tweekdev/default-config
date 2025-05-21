-- Configuration globale des diagnostics pour Neovim
-- Ce fichier centralise toutes les configurations de diagnostic

-- Configuration des icônes et symboles de diagnostic (méthode moderne)
local diagnostic_signs = {
  Error = "✘",
  Warn = "▲",
  Hint = "⚑",
  Info = "»",
}

-- Configuration principale des diagnostics (méthode moderne)
local diagnostic_config = {
  -- Configuration des signes dans la colonne des signes
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = diagnostic_signs.Error },
      { name = "DiagnosticSignWarn", text = diagnostic_signs.Warn },
      { name = "DiagnosticSignHint", text = diagnostic_signs.Hint },
      { name = "DiagnosticSignInfo", text = diagnostic_signs.Info },
    },
  },
  
  -- Désactiver le texte virtuel car on utilise diagflow
  virtual_text = false,
  
  -- Souligner les erreurs
  underline = true,
  
  -- Ne pas mettre à jour pendant l'insertion
  update_in_insert = false,
  
  -- Trier par sévérité
  severity_sort = true,
  
  -- Configuration de la fenêtre flottante de diagnostic
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

-- Appliquer la configuration
vim.diagnostic.config(diagnostic_config)

-- Exporter les fonctions et configurations pour réutilisation
_G.diagnostics = _G.diagnostics or {}

-- Activer les diagnostics
_G.diagnostics.enable = function()
  vim.diagnostic.enable()
  vim.notify("Diagnostics enabled", vim.log.levels.INFO)
end

-- Désactiver les diagnostics
_G.diagnostics.disable = function()
  vim.diagnostic.disable()
  vim.notify("Diagnostics disabled", vim.log.levels.INFO)
end

-- Fonction pour ouvrir le diagnostic sous le curseur
_G.diagnostics.open_float = function()
  vim.diagnostic.open_float({ 
    border = "rounded",
    max_width = 100,
    focusable = true,
  })
end

-- Fonction pour naviguer vers le diagnostic précédent
_G.diagnostics.goto_prev = function()
  vim.diagnostic.goto_prev({ 
    float = { border = "rounded" },
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    }
  })
end

-- Fonction pour naviguer vers le diagnostic suivant
_G.diagnostics.goto_next = function()
  vim.diagnostic.goto_next({ 
    float = { border = "rounded" },
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    }
  })
end

-- Exportation terminée
return diagnostic_config
