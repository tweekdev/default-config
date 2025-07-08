-- Script de correction des problèmes d'affichage Neovim
-- À exécuter avec: nvim -l fix-display.lua

print("🖥️  Correction des problèmes d'affichage Neovim...")

-- Forcer le redraw et rafraîchir l'affichage
vim.cmd("redraw!")
vim.cmd("mode") -- Réafficher le mode

-- Configuration d'affichage optimale
local opt = vim.opt

-- Corrections critiques pour l'affichage
opt.lazyredraw = false        -- Critique: toujours redessiner
opt.ttyfast = true           -- Terminal rapide
opt.redrawtime = 2000        -- Temps maximum pour redraw

-- Interface visible
opt.cmdheight = 1            -- Ligne de commande visible
opt.laststatus = 3           -- Barre de statut globale
opt.showcmd = true           -- Afficher les commandes
opt.showmode = true          -- Afficher le mode
opt.ruler = true             -- Afficher la position du curseur

-- Curseur et ligne courante
opt.cursorline = true        -- Ligne courante visible
opt.colorcolumn = ""         -- Pas de colonne de couleur qui peut interférer

-- Rafraîchissement optimisé
opt.updatetime = 100         -- Rafraîchissement plus rapide pour l'affichage
opt.timeoutlen = 300         -- Délai réduit
opt.ttimeoutlen = 10         -- Très rapide pour les codes ESC

-- Diagnostics avec mise à jour en temps réel
vim.diagnostic.config({
  signs = true,
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  update_in_insert = true,   -- Mise à jour en mode insertion
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
})

-- Corrections spécifiques au terminal
if vim.fn.has('gui_running') == 0 then
  opt.termguicolors = true   -- Couleurs vraies
  -- Note: t_Co n'existe plus dans Neovim moderne
end

-- Autocommandes pour forcer le redraw
vim.api.nvim_create_augroup("DisplayFix", { clear = true })

-- Redraw après l'insertion
vim.api.nvim_create_autocmd("InsertLeave", {
  group = "DisplayFix",
  pattern = "*",
  callback = function()
    vim.cmd("redraw")
  end,
})

-- Redraw après les changements de buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = "DisplayFix",
  pattern = "*",
  callback = function()
    vim.cmd("redraw!")
  end,
})

-- Redraw sur les changements de fenêtre
vim.api.nvim_create_autocmd("WinEnter", {
  group = "DisplayFix",
  pattern = "*",
  callback = function()
    vim.cmd("redraw")
  end,
})

-- Mapping pour forcer le redraw manuellement
vim.keymap.set("n", "<leader>rr", "<cmd>redraw!<cr>", { desc = "Force Redraw" })
vim.keymap.set("i", "<C-l>", "<cmd>redraw<cr>", { desc = "Redraw en insertion", silent = true })

-- Vérifications finales
print("✅ Corrections d'affichage appliquées")
print("📋 Mappings ajoutés:")
print("   <leader>rr - Force redraw (mode normal)")
print("   <C-l>      - Redraw (mode insertion)")
print("")
print("🔧 Si le problème persiste:")
print("   1. Essayez :redraw! dans Neovim")
print("   2. Vérifiez votre terminal (kitty, iterm2, etc.)")
print("   3. Redémarrez complètement Neovim")

-- Test final de redraw
vim.defer_fn(function()
  vim.cmd("redraw!")
  print("🎯 Test de redraw final effectué")
end, 100) 