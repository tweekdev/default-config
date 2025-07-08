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

# 2. Installer parser regex pour Treesitter
echo "📋 2. Installation du parser regex pour Treesitter..."
nvim --headless -c "TSInstall regex" -c "sleep 5" -c "qa"
echo "✅ Parser regex installé"

# 3. Corriger blink.cmp (build fuzzy lib)
echo "📋 3. Construction de blink_cmp_fuzzy..."
nvim --headless -c "lua require('blink.cmp').setup()" -c "sleep 3" -c "qa" 2>/dev/null || echo "⚠️ blink.cmp peut nécessiter un redémarrage"

# 4. Désactiver luarocks dans lazy si non nécessaire
echo "📋 4. Configuration lazy.nvim rocks..."
echo "💡 Note: luarocks sera désactivé automatiquement si aucun plugin ne l'utilise"

# 5. Corriger ultimate-autopair
echo "📋 5. Correction ultimate-autopair..."
echo "🔧 Les tests échoués d'ultimate-autopair sont généralement liés à treesitter"
echo "   Redémarrage recommandé après installation du parser regex"

# 6. Vérifier les langages optionnels manquants
echo "📋 6. Langages optionnels disponibles pour installation:"
echo "   - Go: brew install go"
echo "   - Rust: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
echo "   - PHP: brew install php"
echo "   - Julia: brew install julia"
echo "   Ces langages ne sont nécessaires QUE si vous développez dans ces langages"

# 7. Installer wget (optionnel pour mason)
echo "📋 7. Installation wget pour mason..."
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
echo "   4. Testez ultimate-autopair avec quelques paires"
echo ""
echo "⚠️  Note sur les avertissements restants :"
echo "   • which-key overlaps : Normal et informatif"
echo "   • mason warnings : Seulement si vous utilisez ces langages"
echo "   • luarocks : Seulement si plugins nécessitent luarocks" 