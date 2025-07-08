#!/bin/bash

# Script de correction des problèmes checkhealth
echo "🔧 Correction des problèmes identifiés par checkhealth..."

# 1. Corriger tmux focus-events
echo "📋 1. Configuration tmux focus-events..."
if [ -f ~/.tmux.conf ]; then
  if ! grep -q "focus-events" ~/.tmux.conf; then
    echo "" >> ~/.tmux.conf
    echo "# Fix pour vim autoread" >> ~/.tmux.conf
    echo "set-option -g focus-events on" >> ~/.tmux.conf
    echo "✅ focus-events ajouté à ~/.tmux.conf"
  else
    echo "✅ focus-events déjà configuré"
  fi
else
  echo "⚠️  ~/.tmux.conf non trouvé"
fi

# 2. Installer wget (optionnel pour mason)
echo "📋 2. Installation wget pour mason..."
if ! command -v wget &> /dev/null; then
  if command -v brew &> /dev/null; then
    brew install wget
    echo "✅ wget installé"
  else
    echo "⚠️ brew non disponible, wget non installé"
  fi
else
  echo "✅ wget déjà installé"
fi

echo ""
echo "🎉 Corrections terminées !"
echo ""
echo "📋 Actions requises :"
echo "   1. Redémarrez tmux : tmux kill-server && tmux"
echo "   2. Redémarrez Neovim complètement"
echo "   3. Vérifiez : :checkhealth"
echo ""
echo "⚠️  Note sur les avertissements restants :"
echo "   • which-key overlaps : Normal et informatif"
echo "   • mason warnings : Seulement si vous utilisez ces langages"
echo "   • luarocks : Seulement si plugins nécessitent luarocks"
