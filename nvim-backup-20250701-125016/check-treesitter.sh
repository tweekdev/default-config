#!/bin/bash

# Script de vérification et optimisation Treesitter
echo "🌳 Vérification de la configuration Treesitter..."

echo ""
echo "📋 Instructions pour vérifier Treesitter dans Neovim :"
echo ""

echo "1️⃣  Vérifier l'état des parsers :"
echo "   :TSInstallInfo"
echo ""

echo "2️⃣  Mettre à jour tous les parsers :"
echo "   :TSUpdate"
echo ""

echo "3️⃣  Vérifier les parsers installés :"
echo "   :checkhealth nvim-treesitter"
echo ""

echo "4️⃣  Tester la coloration syntaxique :"
echo "   :TSHighlightCapturesUnderCursor"
echo ""

echo "5️⃣  Vérifier les modules actifs :"
echo "   :lua print(vim.inspect(require('nvim-treesitter.configs').get_module('highlight')))"
echo ""

echo "🔧 Optimisations appliquées :"
echo "✅ Suppression des doublons (json, lua)"
echo "✅ Installation asynchrone (sync_install = false)"
echo "✅ Query linter désactivé (performance)"
echo "✅ Chargement lazy pour de meilleures performances"
echo "✅ Désactivation automatique pour les gros fichiers (>100KB)"
echo "✅ Suppression de la coloration Vim legacy"
echo "✅ Suppression du parser custom 'templ'"
echo "✅ Ajout de text objects pour une navigation efficace"
echo ""

echo "🎯 Raccourcis de navigation ajoutés :"
echo "• <C-space> - Sélection incrémentale"
echo "• <C-s>     - Sélection de scope"
echo "• af/if     - Fonction outer/inner"
echo "• ac/ic     - Classe outer/inner"
echo ""

echo "⚡ Performances améliorées :"
echo "• Folding intelligent (désactivé par défaut)"
echo "• Désactivation automatique sur gros fichiers"
echo "• Moins de parsers inutiles"
echo "• Pas de regex highlighting legacy"
echo ""

echo "🚀 Pour appliquer les changements :"
echo "1. Redémarrez Neovim"
echo "2. Exécutez :TSUpdate"
echo "3. Vérifiez avec :checkhealth nvim-treesitter"
echo ""

echo "💡 Si des erreurs persistent :"
echo "• :TSUninstall <parser> puis :TSInstall <parser>"
echo "• Nettoyer le cache : rm -rf ~/.local/share/nvim/lazy/nvim-treesitter"
echo "• Redémarrer complètement Neovim" 