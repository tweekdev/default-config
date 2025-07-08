#!/bin/bash

# Script de correction rapide des problèmes d'affichage Neovim
echo "🖥️  Correction des problèmes d'affichage Neovim..."

# Appliquer les corrections via le script Lua
echo "🔧 Application des corrections d'affichage..."
nvim --headless -l fix-display.lua -c "qa"

echo ""
echo "✅ Corrections appliquées !"
echo ""
echo "📋 Solutions pour les problèmes d'affichage courants:"
echo "   • Texte qui n'apparaît pas pendant la frappe"
echo "   • Écran qui ne se rafraîchit pas"
echo "   • Interface qui disparaît"
echo ""
echo "🎯 Nouvelles commandes disponibles dans Neovim:"
echo "   :redraw!           - Force le redraw complet"
echo "   <leader>rr         - Force redraw (mode normal)"
echo "   <Ctrl-l>           - Redraw rapide (mode insertion)"
echo ""
echo "🔍 Test recommandé:"
echo "   1. Ouvrez Neovim: nvim test.html"
echo "   2. Tapez: div.container"
echo "   3. Le texte devrait maintenant apparaître immédiatement"
echo ""
echo "💡 Si le problème persiste:"
echo "   • Vérifiez les paramètres de votre terminal"
echo "   • Essayez dans un autre terminal"
echo "   • Redémarrez complètement Neovim" 