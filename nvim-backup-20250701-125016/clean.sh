#!/bin/bash

# Script de nettoyage pour Neovim
echo "🧹 Nettoyage de la configuration Neovim..."

# Supprimer les caches
echo "🗑️ Suppression des caches..."
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Supprimer les logs
echo "📝 Suppression des logs..."
rm -rf ~/.local/state/nvim/log

echo "✅ Nettoyage terminé !"
echo "🚀 Redémarrez Neovim pour que les changements prennent effet."
echo "📦 Les plugins inutilisés seront automatiquement supprimés par Lazy.nvim" 