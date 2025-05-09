-- Configuration globale des diagnostics pour Neovim
-- Ce fichier centralise toutes les configurations de diagnostic

-- Configuration des icônes et symboles de diagnostic
local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "✘", texthl = "DiagnosticSignError" },
  { name = "DiagnosticSignWarn", text = "▲", texthl = "DiagnosticSignWarn" },
  { name = "DiagnosticSignHint", text = "⚑", texthl = "DiagnosticSignHint" },
  { name = "DiagnosticSignInfo", text = "»", texthl = "DiagnosticSignInfo" },
}

-- Définir les signes de diagnostic
for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, {
    text = sign.text,
    texthl = sign.texthl,
    numhl = sign.texthl,
  })
end

-- Configuration principale des diagnostics
local diagnostic_config = {
  signs = true,
  virtual_text = false, -- Désactivé car nous utilisons diagflow
  underline = true,
  update_in_insert = false,
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
